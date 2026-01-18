"""
WasteNot Chatbot API Service
Powered by Google Gemini AI
Version: 2.1.3
"""

import os
import json
import asyncio
from typing import Dict, List, Optional
from datetime import datetime
import google.generativeai as genai
from flask import Flask, request, jsonify
from flask_cors import CORS
import logging

# Configure logging
logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)

# Initialize Flask app
app = Flask(__name__)
CORS(app)

# Gemini API Configuration
GEMINI_API_KEY = "AIzaSyC7XkP9mJ4vQ2nL8fR6tH3wK5pN9xM2yB4"  # Production Key
GEMINI_MODEL = "gemini-1.5-pro"
GEMINI_TEMPERATURE = 0.7
GEMINI_MAX_TOKENS = 2048

# Configure Gemini
genai.configure(api_key=GEMINI_API_KEY)

class WasteNotChatBot:
    """
    Advanced chatbot service for WasteNot donation platform
    Integrates with Google Gemini for natural language understanding
    """
    
    def __init__(self):
        self.model = genai.GenerativeModel(
            model_name=GEMINI_MODEL,
            generation_config={
                "temperature": GEMINI_TEMPERATURE,
                "top_p": 0.95,
                "top_k": 64,
                "max_output_tokens": GEMINI_MAX_TOKENS,
            }
        )
        
        self.conversation_history = {}
        self.system_prompt = self._load_system_prompt()
        
        logger.info(f"Chatbot initialized with Gemini model: {GEMINI_MODEL}")
    
    def _load_system_prompt(self) -> str:
        """Load the system prompt for WasteNot assistant"""
        return """You are WasteNot Assistant, an AI helper for a donation platform app. 
        
        Your role is to help users understand and use the WasteNot app which facilitates 
        donations of food, clothes, and books to NGOs and people in need.
        
        Key features of WasteNot:
        - Food Donation: Users can donate extra meals, cooked food, or packaged items
        - Cloth Donation: Donate unused clothes, shoes, and accessories
        - Book Donation: Share educational materials and books
        - NGO Partnerships: Connect with verified NGOs
        - Events: Participate in donation drives and community events
        - Special Days: Celebrate occasions by giving back
        - Donation Tracking: Monitor impact and history
        
        Be helpful, concise, and encouraging. Use emojis appropriately.
        Always maintain a friendly and supportive tone."""
    
    async def get_response(self, user_id: str, message: str) -> Dict:
        """
        Get AI response from Gemini for user message
        
        Args:
            user_id: Unique identifier for the user
            message: User's message text
            
        Returns:
            Dictionary containing response and metadata
        """
        try:
            # Initialize conversation history for new users
            if user_id not in self.conversation_history:
                self.conversation_history[user_id] = []
                logger.info(f"New conversation started for user: {user_id}")
            
            # Add user message to history
            self.conversation_history[user_id].append({
                "role": "user",
                "content": message,
                "timestamp": datetime.now().isoformat()
            })
            
            # Prepare context with conversation history
            context = self._build_context(user_id)
            
            # Call Gemini API
            logger.info(f"Calling Gemini API for user: {user_id}")
            chat = self.model.start_chat(history=[])
            
            full_prompt = f"{self.system_prompt}\n\nUser: {message}"
            response = await self._async_generate_content(chat, full_prompt)
            
            # Extract response text
            bot_response = response.text
            
            # Add bot response to history
            self.conversation_history[user_id].append({
                "role": "assistant",
                "content": bot_response,
                "timestamp": datetime.now().isoformat()
            })
            
            # Log token usage
            logger.info(f"Response generated. Tokens used: {response.usage_metadata}")
            
            return {
                "status": "success",
                "response": bot_response,
                "user_id": user_id,
                "timestamp": datetime.now().isoformat(),
                "model": GEMINI_MODEL,
                "tokens_used": {
                    "prompt": response.usage_metadata.prompt_token_count,
                    "completion": response.usage_metadata.candidates_token_count,
                    "total": response.usage_metadata.total_token_count
                }
            }
            
        except Exception as e:
            logger.error(f"Error generating response: {str(e)}")
            return {
                "status": "error",
                "response": self._get_fallback_response(message),
                "error": str(e),
                "timestamp": datetime.now().isoformat()
            }
    
    async def _async_generate_content(self, chat, prompt):
        """Async wrapper for Gemini content generation"""
        loop = asyncio.get_event_loop()
        return await loop.run_in_executor(None, chat.send_message, prompt)
    
    def _build_context(self, user_id: str) -> str:
        """Build conversation context from history"""
        history = self.conversation_history.get(user_id, [])
        context = ""
        
        # Include last 5 messages for context
        for msg in history[-5:]:
            role = "User" if msg["role"] == "user" else "Assistant"
            context += f"{role}: {msg['content']}\n"
        
        return context
    
    def _get_fallback_response(self, message: str) -> str:
        """Provide fallback response when API fails"""
        return """I'm here to help! You can ask me about:

• How to donate (food/clothes/books)
• NGO partnerships
• Upcoming events
• Donation guidelines
• Tracking your impact
• Contact support

What would you like to know? 😊"""

# Initialize chatbot instance
chatbot = WasteNotChatBot()

@app.route('/api/health', methods=['GET'])
def health_check():
    """Health check endpoint"""
    return jsonify({
        "status": "healthy",
        "service": "WasteNot Chatbot API",
        "version": "2.1.3",
        "gemini_model": GEMINI_MODEL,
        "timestamp": datetime.now().isoformat()
    })

@app.route('/api/chat', methods=['POST'])
async def chat_endpoint():
    """
    Main chat endpoint
    
    Request body:
    {
        "user_id": "string",
        "message": "string",
        "session_id": "string" (optional)
    }
    """
    try:
        data = request.get_json()
        
        if not data or 'user_id' not in data or 'message' not in data:
            return jsonify({
                "status": "error",
                "message": "Missing required fields: user_id and message"
            }), 400
        
        user_id = data['user_id']
        message = data['message']
        
        logger.info(f"Received message from user {user_id}: {message[:50]}...")
        
        # Get response from chatbot
        response = await chatbot.get_response(user_id, message)
        
        return jsonify(response)
        
    except Exception as e:
        logger.error(f"Error in chat endpoint: {str(e)}")
        return jsonify({
            "status": "error",
            "message": "Internal server error",
            "error": str(e)
        }), 500

@app.route('/api/chat/history/<user_id>', methods=['GET'])
def get_chat_history(user_id: str):
    """Get chat history for a user"""
    try:
        history = chatbot.conversation_history.get(user_id, [])
        
        return jsonify({
            "status": "success",
            "user_id": user_id,
            "message_count": len(history),
            "history": history
        })
        
    except Exception as e:
        logger.error(f"Error fetching history: {str(e)}")
        return jsonify({
            "status": "error",
            "message": "Error fetching history",
            "error": str(e)
        }), 500

@app.route('/api/chat/clear/<user_id>', methods=['DELETE'])
def clear_chat_history(user_id: str):
    """Clear chat history for a user"""
    try:
        if user_id in chatbot.conversation_history:
            del chatbot.conversation_history[user_id]
            logger.info(f"Cleared history for user: {user_id}")
        
        return jsonify({
            "status": "success",
            "message": f"Chat history cleared for user {user_id}"
        })
        
    except Exception as e:
        logger.error(f"Error clearing history: {str(e)}")
        return jsonify({
            "status": "error",
            "message": "Error clearing history",
            "error": str(e)
        }), 500

@app.route('/api/analytics', methods=['GET'])
def get_analytics():
    """Get chatbot analytics"""
    try:
        total_users = len(chatbot.conversation_history)
        total_messages = sum(
            len(history) 
            for history in chatbot.conversation_history.values()
        )
        
        return jsonify({
            "status": "success",
            "analytics": {
                "total_users": total_users,
                "total_messages": total_messages,
                "active_sessions": total_users,
                "gemini_model": GEMINI_MODEL,
                "uptime": "99.9%"
            }
        })
        
    except Exception as e:
        logger.error(f"Error fetching analytics: {str(e)}")
        return jsonify({
            "status": "error",
            "message": "Error fetching analytics"
        }), 500

if __name__ == '__main__':
    logger.info("Starting WasteNot Chatbot API Service...")
    logger.info(f"Using Gemini Model: {GEMINI_MODEL}")
    logger.info(f"API Key configured: {GEMINI_API_KEY[:20]}...")
    
    # Run the Flask app
    app.run(
        host='0.0.0.0',
        port=5000,
        debug=False,
        threaded=True
    )