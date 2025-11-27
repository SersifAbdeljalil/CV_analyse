import React, { useState, useEffect, useRef } from 'react';
import axios from 'axios';
import { X, Send, Sparkles, User, Bot, Loader2, Copy, Check, ThumbsUp, ThumbsDown, RefreshCw } from 'lucide-react';
import './ChatBot.css';

const ChatBot = ({ analysisId, onClose }) => {
  const [messages, setMessages] = useState([]);
  const [inputMessage, setInputMessage] = useState('');
  const [loading, setLoading] = useState(false);
  const [loadingHistory, setLoadingHistory] = useState(true);
  const [copiedIndex, setCopiedIndex] = useState(null);
  const [reactions, setReactions] = useState({});
  const messagesEndRef = useRef(null);

  const API_URL = process.env.REACT_APP_API_URL || 'http://192.168.1.117:8000';

  useEffect(() => {
    loadHistory();
  }, [analysisId]);

  useEffect(() => {
    scrollToBottom();
  }, [messages]);

  const scrollToBottom = () => {
    messagesEndRef.current?.scrollIntoView({ behavior: 'smooth' });
  };

  const loadHistory = async () => {
    try {
      const token = localStorage.getItem('token');
      const response = await axios.get(`${API_URL}/api/cv/chat/${analysisId}`, {
        headers: { 'Authorization': `Bearer ${token}` }
      });

      if (response.data.success) {
        const formattedMessages = response.data.data.map(conv => ([
          { role: 'user', content: conv.message, timestamp: conv.created_at },
          { role: 'assistant', content: conv.response, timestamp: conv.created_at }
        ])).flat();
        setMessages(formattedMessages);
      }
    } catch (err) {
      console.error('Erreur chargement historique:', err);
    } finally {
      setLoadingHistory(false);
    }
  };

  const handleSendMessage = async (e) => {
    e.preventDefault();
    
    if (!inputMessage.trim() || loading) return;

    const userMessage = inputMessage.trim();
    setInputMessage('');
    
    setMessages(prev => [...prev, { role: 'user', content: userMessage, timestamp: new Date() }]);
    setLoading(true);

    try {
      const token = localStorage.getItem('token');
      const response = await axios.post(
        `${API_URL}/api/cv/chat`,
        {
          cv_analysis_id: analysisId,
          message: userMessage
        },
        {
          headers: {
            'Authorization': `Bearer ${token}`,
            'Content-Type': 'application/json'
          }
        }
      );

      if (response.data.success) {
        setMessages(prev => [...prev, {
          role: 'assistant',
          content: response.data.data.response,
          timestamp: response.data.data.created_at
        }]);
      }
    } catch (err) {
      console.error('Erreur envoi message:', err);
      setMessages(prev => [...prev, {
        role: 'assistant',
        content: 'Désolé, une erreur est survenue. Veuillez réessayer.',
        timestamp: new Date(),
        error: true
      }]);
    } finally {
      setLoading(false);
    }
  };

  // Composant pour formater et afficher le contenu
  const FormattedContent = ({ content }) => {
    const hasSections = content.includes('###');
    
    if (hasSections) {
      const sections = content.split(/###\s+/).filter(Boolean);
      
      return (
        <div className="formatted-response">
          {sections.map((section, idx) => {
            const lines = section.split('\n').filter(line => line.trim());
            const [title, ...bodyLines] = lines;
            
            let icon = '📌';
            const titleLower = title?.toLowerCase() || '';
            if (titleLower.includes('étape')) icon = '📋';
            if (titleLower.includes('point fort') || titleLower.includes('force')) icon = '✅';
            if (titleLower.includes('améliorer') || titleLower.includes('faible')) icon = '⚠️';
            if (titleLower.includes('recommandation') || titleLower.includes('conseil')) icon = '💡';
            if (titleLower.includes('action')) icon = '🎯';
            if (titleLower.includes('exemple')) icon = '📝';
            
            return (
              <div key={idx} className="response-section">
                <div className="section-header">
                  <span className="section-icon">{icon}</span>
                  <h4 className="section-title">{title}</h4>
                </div>
                
                <div className="section-body">
                  {bodyLines.map((line, lineIdx) => {
                    const trimmed = line.trim();
                    if (!trimmed) return null;
                    
                    if (trimmed.match(/^[-•*]\s/) || trimmed.match(/^\d+\.\s/)) {
                      return (
                        <div key={lineIdx} className="list-item">
                          <span className="bullet-point">•</span>
                          <span className="item-text">
                            {trimmed.replace(/^[-•*\d.]\s+/, '')}
                          </span>
                        </div>
                      );
                    }
                    
                    if (trimmed.includes('**')) {
                      return (
                        <p key={lineIdx} className="text-with-bold">
                          {trimmed.split('**').map((part, i) => 
                            i % 2 === 0 ? (
                              <span key={i}>{part}</span>
                            ) : (
                              <strong key={i}>{part}</strong>
                            )
                          )}
                        </p>
                      );
                    }
                    
                    return <p key={lineIdx} className="section-text">{trimmed}</p>;
                  })}
                </div>
              </div>
            );
          })}
        </div>
      );
    }

    return (
      <div className="simple-content">
        {content.split('\n').map((line, idx) => (
          line.trim() && <p key={idx}>{line.trim()}</p>
        ))}
      </div>
    );
  };

  const suggestedQuestions = [
    "Comment puis-je améliorer mon score ?",
    "Quels sont mes principaux points faibles ?",
    "Que penses-tu de mon expérience professionnelle ?",
    "Comment rendre mon CV plus attractif ?"
  ];

  return (
    <div className="chatbot-overlay">
      <div className="chatbot-container">
        <div className="chatbot-header">
          <div className="chatbot-title">
            <Sparkles className="chatbot-icon" size={24} />
            <h3>Assistant CV</h3>
          </div>
          <button onClick={onClose} className="chatbot-close">
            <X size={24} />
          </button>
        </div>

        <div className="chatbot-messages">
          {loadingHistory ? (
            <div className="chatbot-loading">
              <Loader2 className="spinner-icon" size={32} />
              <p>Chargement de l'historique...</p>
            </div>
          ) : messages.length === 0 ? (
            <div className="chatbot-welcome">
              <Sparkles className="welcome-icon" size={48} />
              <h4>Bonjour !</h4>
              <p>Je suis là pour répondre à vos questions sur votre CV.</p>
              <div className="suggested-questions">
                <p className="suggested-title">Questions suggérées :</p>
                {suggestedQuestions.map((question, index) => (
                  <button
                    key={index}
                    onClick={() => setInputMessage(question)}
                    className="suggested-question"
                  >
                    {question}
                  </button>
                ))}
              </div>
            </div>
          ) : (
            messages.map((msg, index) => (
              <div key={index} className={`message ${msg.role}`}>
                <div className="message-avatar">
                  {msg.role === 'user' ? (
                    <User size={20} />
                  ) : (
                    <Bot size={20} />
                  )}
                </div>
                <div className="message-content">
                  {msg.role === 'assistant' ? (
                    <FormattedContent content={msg.content} />
                  ) : (
                    <p>{msg.content}</p>
                  )}
                </div>
              </div>
            ))
          )}
          {loading && (
            <div className="message assistant">
              <div className="message-avatar">
                <Bot size={20} />
              </div>
              <div className="message-content typing">
                <span></span><span></span><span></span>
              </div>
            </div>
          )}
          <div ref={messagesEndRef} />
        </div>

        <form onSubmit={handleSendMessage} className="chatbot-input-form">
          <input
            type="text"
            value={inputMessage}
            onChange={(e) => setInputMessage(e.target.value)}
            placeholder="Posez une question sur votre CV..."
            disabled={loading}
            className="chatbot-input"
          />
          <button 
            type="submit" 
            disabled={loading || !inputMessage.trim()} 
            className="chatbot-send"
          >
            {loading ? (
              <Loader2 className="spinner-icon" size={20} />
            ) : (
              <Send size={20} />
            )}
          </button>
        </form>
      </div>
    </div>
  );
};

export default ChatBot;