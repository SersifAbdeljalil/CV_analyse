import React, { useState, useEffect } from 'react';
import { useNavigate } from 'react-router-dom';
import axios from 'axios';
import { Upload, FileText, TrendingUp, AlertCircle, MessageCircle, LogOut, Clock, CheckCircle, AlertTriangle } from 'lucide-react';
import ChatBot from './ChatBot';
import './Analyzer.css';

const Analyzer = () => {
  const [selectedFile, setSelectedFile] = useState(null);
  const [loading, setLoading] = useState(false);
  const [analysis, setAnalysis] = useState(null);
  const [error, setError] = useState('');
  const [history, setHistory] = useState([]);
  const [chatOpen, setChatOpen] = useState(false);
  const [showChat, setShowChat] = useState(false);
  const navigate = useNavigate();

  // CORRECTION : Utiliser la variable d'environnement
  const API_URL = process.env.REACT_APP_API_URL || 'http://localhost:8000';

  useEffect(() => {
    const token = localStorage.getItem('token');
    if (!token) {
      navigate('/login');
      return;
    }
    loadHistory();
  }, [navigate]);

  const loadHistory = async () => {
    try {
      const token = localStorage.getItem('token');
      const response = await axios.get(`${API_URL}/api/cv/history`, {
        headers: { 
          'Authorization': `Bearer ${token}`,
          'Content-Type': 'application/json',
          'Accept': 'application/json'
        }
      });
      if (response.data.success) {
        setHistory(response.data.data);
      }
    } catch (err) {
      console.error('Erreur chargement historique:', err);
    }
  };

  const handleFileChange = (e) => {
    const file = e.target.files[0];
    if (file) {
      const validTypes = ['application/pdf', 'application/msword', 'application/vnd.openxmlformats-officedocument.wordprocessingml.document'];
      if (!validTypes.includes(file.type)) {
        setError('Veuillez sélectionner un fichier PDF, DOC ou DOCX');
        return;
      }
      if (file.size > 5 * 1024 * 1024) {
        setError('Le fichier ne doit pas dépasser 5 Mo');
        return;
      }
      setSelectedFile(file);
      setError('');
      setAnalysis(null);
    }
  };

  const handleAnalyze = async () => {
    if (!selectedFile) {
      setError('Veuillez sélectionner un fichier CV');
      return;
    }

    setLoading(true);
    setError('');

    try {
      const token = localStorage.getItem('token');
      const formData = new FormData();
      formData.append('cv_file', selectedFile);

      const response = await axios.post(`${API_URL}/api/cv/analyze`, formData, {
        headers: {
          'Authorization': `Bearer ${token}`,
          'Content-Type': 'multipart/form-data',
          'Accept': 'application/json'
        }
      });

      if (response.data.success) {
        setAnalysis(response.data.data);
        loadHistory();
      }
    } catch (err) {
      if (err.response?.status === 401) {
        localStorage.removeItem('token');
        navigate('/login');
      } else {
        setError(err.response?.data?.message || err.response?.data?.error || 'Une erreur est survenue lors de l\'analyse');
        console.error('Erreur complète:', err.response?.data);
      }
    } finally {
      setLoading(false);
    }
  };

  const handleLogout = () => {
    localStorage.removeItem('token');
    localStorage.removeItem('user');
    navigate('/login');
  };

  const getScoreColor = (score) => {
    if (score >= 80) return '#d4af37';
    if (score >= 60) return '#f4d03f';
    return '#ff6b6b';
  };

  const getPriorityBadge = (priority) => {
    const colors = { 
      'haute': '#ff6b6b', 
      'moyenne': '#f4d03f', 
      'basse': '#d4af37' 
    };
    return colors[priority] || '#6b7280';
  };

  return (
    <div className="analyzer-container">
      <header className="analyzer-header">
        <div className="header-content">
          <h1>
            <TrendingUp className="header-icon" size={32} />
            CV Analyzer
          </h1>
          <button onClick={handleLogout} className="btn-logout">
            <LogOut size={18} />
            Déconnexion
          </button>
        </div>
      </header>

      <div className="analyzer-content">
        <div className="upload-section">
          <h2>
            <Upload size={24} />
            Analyser un nouveau CV
          </h2>
          <div className="upload-area">
            <input
              type="file"
              id="cv-upload"
              accept=".pdf,.doc,.docx"
              onChange={handleFileChange}
              disabled={loading}
              style={{ display: 'none' }}
            />
            <label htmlFor="cv-upload" className="upload-label">
              <FileText className="upload-icon" size={48} />
              <p className="upload-text">
                {selectedFile ? selectedFile.name : 'Cliquez pour sélectionner un CV'}
              </p>
              <span className="upload-hint">PDF, DOC ou DOCX (Max 5 Mo)</span>
            </label>
          </div>

          {error && (
            <div className="error-message">
              <AlertCircle size={20} />
              {error}
            </div>
          )}

          <button onClick={handleAnalyze} disabled={!selectedFile || loading} className="btn-analyze">
            {loading ? (
              <>
                <span className="spinner"></span>
                Analyse en cours...
              </>
            ) : (
              <>
                <TrendingUp size={20} />
                Analyser le CV
              </>
            )}
          </button>
        </div>

        {analysis && (
          <div className="analysis-result">
            <div className="result-header">
              <h2>
                <TrendingUp size={24} />
                Résultat de l'analyse
              </h2>
              <button onClick={() => setShowChat(true)} className="btn-chat">
                <MessageCircle size={18} />
                Discuter avec l'assistant
              </button>
            </div>

            <div className="score-card">
              <div className="score-circle" style={{ background: `conic-gradient(${getScoreColor(analysis.overall_score)} ${analysis.overall_score * 3.6}deg, #2d2d2d 0deg)` }}>
                <div className="score-inner">
                  <span className="score-value">{analysis.overall_score}</span>
                  <span className="score-label">/100</span>
                </div>
              </div>
              <p className="score-summary">{analysis.summary}</p>
            </div>

            <div className="section-scores">
              <h3>Scores par section</h3>
              <div className="scores-grid">
                {Object.entries(analysis.section_scores).map(([section, score]) => (
                  <div key={section} className="score-item">
                    <div className="score-bar-container">
                      <div className="score-bar" style={{ width: `${score}%`, backgroundColor: getScoreColor(score) }}></div>
                    </div>
                    <div className="score-label-row">
                      <span className="section-name">{section}</span>
                      <span className="section-score">{score}/100</span>
                    </div>
                  </div>
                ))}
              </div>
            </div>

            {analysis.strengths && analysis.strengths.length > 0 && (
              <div className="strengths-section">
                <h3>
                  <CheckCircle size={22} />
                  Points forts
                </h3>
                <ul className="points-list">
                  {analysis.strengths.map((strength, index) => (
                    <li key={index}>
                      <CheckCircle size={16} className="point-icon" />
                      {strength}
                    </li>
                  ))}
                </ul>
              </div>
            )}

            {analysis.weaknesses && analysis.weaknesses.length > 0 && (
              <div className="weaknesses-section">
                <h3>
                  <AlertTriangle size={22} />
                  Points à améliorer
                </h3>
                <ul className="points-list">
                  {analysis.weaknesses.map((weakness, index) => (
                    <li key={index}>
                      <AlertTriangle size={16} className="point-icon" />
                      {weakness}
                    </li>
                  ))}
                </ul>
              </div>
            )}

            <div className="recommendations-section">
              <h3>
                <TrendingUp size={22} />
                Recommandations
              </h3>
              <div className="recommendations-list">
                {analysis.recommendations.map((rec, index) => (
                  <div key={index} className="recommendation-card">
                    <div className="recommendation-header">
                      <span className="recommendation-category">{rec.category}</span>
                      <span className="priority-badge" style={{ backgroundColor: getPriorityBadge(rec.priority) }}>
                        {rec.priority}
                      </span>
                    </div>
                    <p className="recommendation-text">{rec.suggestion}</p>
                  </div>
                ))}
              </div>
            </div>
          </div>
        )}

        {history.length > 0 && (
          <div className="history-section">
            <h2>
              <Clock size={24} />
              Historique des analyses
            </h2>
            <div className="history-list">
              {history.map((item) => (
                <div key={item.id} className="history-item">
                  <div className="history-info">
                    <FileText size={18} className="history-icon" />
                    <span className="history-filename">{item.original_filename}</span>
                    <span className="history-date">
                      {new Date(item.created_at).toLocaleDateString('fr-FR')}
                    </span>
                  </div>
                  <div className="history-score" style={{ color: getScoreColor(item.overall_score) }}>
                    {item.overall_score}/100
                  </div>
                </div>
              ))}
            </div>
          </div>
        )}

        {showChat && analysis && (
          <ChatBot 
            analysisId={analysis.analysis_id} 
            onClose={() => setShowChat(false)} 
          />
        )}
      </div>
    </div>
  );
};

export default Analyzer;
