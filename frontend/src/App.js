import React, { useState } from 'react';
import { BrowserRouter, Routes, Route, Navigate } from 'react-router-dom';
import Login from './pages/Login';
import Signup from './pages/Signup';
import Analyzer from './pages/Analyzer';
import ChatBot from './pages/ChatBot';

function App() {
  const [showChat, setShowChat] = useState(false);
  const [analysisId, setAnalysisId] = useState(null);

  const handleOpenChat = (id) => {
    setAnalysisId(id);
    setShowChat(true);
  };

  const handleCloseChat = () => {
    setShowChat(false);
    setAnalysisId(null);
  };

  return (
    <BrowserRouter>
      <Routes>
        <Route path="/login" element={<Login />} />
        <Route path="/signup" element={<Signup />} />
        <Route 
          path="/analyzer" 
          element={<Analyzer onOpenChat={handleOpenChat} />} 
        />
        <Route path="/" element={<Navigate to="/login" />} />
      </Routes>

      {/* ChatBot Global */}
      {showChat && analysisId && (
        <ChatBot 
          analysisId={analysisId} 
          onClose={handleCloseChat} 
        />
      )}
    </BrowserRouter>
  );
}

export default App;