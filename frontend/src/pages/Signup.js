import React, { useState } from 'react';
import { useNavigate, Link } from 'react-router-dom';
import axios from 'axios';
import { Eye, EyeOff, Mail, Lock, User } from 'lucide-react';
import '../Auth.css';

const Signup = () => {
  const [formData, setFormData] = useState({
    name: '',
    email: '',
    password: '',
    password_confirmation: ''
  });
  const [errors, setErrors] = useState({});
  const [loading, setLoading] = useState(false);
  const [showPassword, setShowPassword] = useState(false);
  const [showConfirmPassword, setShowConfirmPassword] = useState(false);
  const navigate = useNavigate();

  // CORRECTION : Utiliser la variable d'environnement
  const API_URL = process.env.REACT_APP_API_URL || 'http://localhost:8000';

  const handleChange = (e) => {
    setFormData({
      ...formData,
      [e.target.name]: e.target.value
    });
    // Effacer l'erreur du champ modifié
    if (errors[e.target.name]) {
      setErrors({
        ...errors,
        [e.target.name]: ''
      });
    }
  };

  const handleSubmit = async (e) => {
    e.preventDefault();
    setLoading(true);
    setErrors({});

    try {
      const response = await axios.post(`${API_URL}/api/register`, {
        name: formData.name,
        email: formData.email,
        password: formData.password,
        password_confirmation: formData.password_confirmation
      }, {
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json'
        }
      });

      if (response.data.success) {
        // Redirection vers la page de connexion après inscription réussie
        navigate('/login', { 
          state: { 
            message: 'Inscription réussie ! Vous pouvez maintenant vous connecter.' 
          } 
        });
      }
    } catch (err) {
      if (err.response?.data?.errors) {
        // Erreurs de validation du backend
        setErrors(err.response.data.errors);
      } else {
        setErrors({
          general: err.response?.data?.message || 'Une erreur est survenue lors de l\'inscription'
        });
      }
      console.error('Erreur d\'inscription:', err);
    } finally {
      setLoading(false);
    }
  };

  return (
    <div className="auth-container">
      <div className="auth-card">
        <div className="auth-header">
          <h1>🎯 CV Analyzer</h1>
          <h2>Inscription</h2>
          <p>Créez votre compte pour commencer à analyser des CVs</p>
        </div>

        <form onSubmit={handleSubmit} className="auth-form">
          {errors.general && (
            <div className="error-message">
              ⚠️ {errors.general}
            </div>
          )}

          <div className="form-group">
            <label htmlFor="name">Nom complet</label>
            <div className="input-wrapper">
              <User className="input-icon" size={20} />
              <input
                type="text"
                id="name"
                name="name"
                value={formData.name}
                onChange={handleChange}
                placeholder="SERSIF Abdeljalil"
                required
                disabled={loading}
                className={errors.name ? 'input-error' : ''}
              />
            </div>
            {errors.name && (
              <span className="field-error">{errors.name[0]}</span>
            )}
          </div>

          <div className="form-group">
            <label htmlFor="email">Email</label>
            <div className="input-wrapper">
              <Mail className="input-icon" size={20} />
              <input
                type="email"
                id="email"
                name="email"
                value={formData.email}
                onChange={handleChange}
                placeholder="exemple@email.com"
                required
                disabled={loading}
                className={errors.email ? 'input-error' : ''}
              />
            </div>
            {errors.email && (
              <span className="field-error">{errors.email[0]}</span>
            )}
          </div>

          <div className="form-group">
            <label htmlFor="password">Mot de passe</label>
            <div className="input-wrapper">
              <Lock className="input-icon" size={20} />
              <input
                type={showPassword ? "text" : "password"}
                id="password"
                name="password"
                value={formData.password}
                onChange={handleChange}
                placeholder="••••••••"
                required
                disabled={loading}
                className={errors.password ? 'input-error' : ''}
              />
              <button
                type="button"
                className="toggle-password"
                onClick={() => setShowPassword(!showPassword)}
                disabled={loading}
              >
                {showPassword ? <EyeOff size={20} /> : <Eye size={20} />}
              </button>
            </div>
            {errors.password && (
              <span className="field-error">{errors.password[0]}</span>
            )}
            <small className="field-hint">Minimum 8 caractères</small>
          </div>

          <div className="form-group">
            <label htmlFor="password_confirmation">Confirmer le mot de passe</label>
            <div className="input-wrapper">
              <Lock className="input-icon" size={20} />
              <input
                type={showConfirmPassword ? "text" : "password"}
                id="password_confirmation"
                name="password_confirmation"
                value={formData.password_confirmation}
                onChange={handleChange}
                placeholder="••••••••"
                required
                disabled={loading}
              />
              <button
                type="button"
                className="toggle-password"
                onClick={() => setShowConfirmPassword(!showConfirmPassword)}
                disabled={loading}
              >
                {showConfirmPassword ? <EyeOff size={20} /> : <Eye size={20} />}
              </button>
            </div>
          </div>

          <button 
            type="submit" 
            className="btn-primary"
            disabled={loading}
          >
            {loading ? 'Inscription...' : 'S\'inscrire'}
          </button>
        </form>

        <div className="auth-footer">
          <p>
            Vous avez déjà un compte ? {' '}
            <Link to="/login">Se connecter</Link>
          </p>
        </div>
      </div>
    </div>
  );
};

export default Signup;
