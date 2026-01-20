"""
WasteNot Chatbot API Service
Powered by Google Gemini AI
Version: 2.2.0
"""

import os
import json
import asyncio
import time
from typing import Dict, List
from datetime import datetime
import google.generativeai as genai
from flask import Flask, request, jsonify
from flask_cors import CORS
import logging

# ===============================
# Configuration
# ===============================

API_KEY = os.getenv("API_KEY", "WN_DEMO_KEY")
GEMINI_API_KEY = os.getenv("GEMINI_API_KEY", "sk9F3Kp2XQmA7ZL8R4WJcH0VYdE6N1bGxX")
GEMINI_MODEL = "gemini-1.5-pro"
GEMINI_TEMPERATURE = 0.7
GEMINI_MAX_TOKENS = 2048
RATE_LIMIT = 60  # requests per minute per user

# ===============================
# Logging
# ===============================

logging.basicConfig(level=logging.INFO)
logger = logging.getLogger("WasteNot")

# ===============================
# Flask App
# ===============================

app = Flask(__name__)
CORS(app)

# ===============================
# Gemini Setup
# ===============================

genai.configure(api_key=GEMINI_API_KEY)

# ===============================
# In-Memory Stores (Demo)
# ===============================

RATE_LIMIT_STORE = {}
CACHE = {}
USER_PROFILES = {}
FEEDBACKS = []

# ===============================
# Middleware
# ===============================

def check_api_key():
    key = request.headers.get("X-WasteNot-API-Key")
    if key != API_KEY:
        return jsonify({"status": "error", "message": "Invalid API Key"}), 401

def rate_limit(user_id):
    now = time.time()
    window = 60
    RATE_LIMIT_STORE.setdefault(user_id, [])
    RATE_LIMIT_STORE[user_id] = [t for t in RATE_LIMIT_STORE[user_id] if now - t < window]
    if len(RATE_LIMIT_STORE[user_id]) >= RATE_LIMIT:
        return False
    RATE_LIMIT_STORE[user_id].append(now)
    return True

# ===============================
# Chatbot Class
# ===============================

class WasteNotChatBot:
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
        self.history = {}
        self.system_prompt = self._load_prompt()
        logger.info("Chatbot Initialized")

    def _load_prompt(self):
        return """You are WasteNot Assistant.
You help users donate food, clothes, and books.
Be kind, short, and helpful. Use emojis."""

    async def get_response(self, user_id, message):
        try:
            self.history.setdefault(user_id, [])
            self.history[user_id].append({"role":"user","content":message})

            chat = self.model.start_chat(history=[])
            full_prompt = f"{self.system_prompt}\nUser: {message}"
            loop = asyncio.get_event_loop()
            response = await loop.run_in_executor(None, chat.send_message, full_prompt)

            reply = response.text
            self.history[user_id].append({"role":"assistant","content":reply})

            return {"status":"success","response":reply,"time":datetime.now().isoformat()}
        except Exception as e:
            return {"status":"error","response":"Service busy. Try again.","error":str(e)}

chatbot = WasteNotChatBot()

# ===============================
# Routes
# ===============================

@app.before_request
def auth():
    if request.path.startswith("/api"):
        if request.path != "/api/health":
            res = check_api_key()
            if res:
                return res

@app.route("/api/health")
def health():
    return jsonify({"status":"ok","service":"WasteNot","time":datetime.now().isoformat()})

@app.route("/api/chat", methods=["POST"])
async def chat():
    data = request.get_json()
    user_id = data.get("user_id")
    msg = data.get("message")

    if not user_id or not msg:
        return jsonify({"status":"error","message":"user_id and message required"}),400

    if not rate_limit(user_id):
        return jsonify({"status":"error","message":"Too many requests"}),429

    cache_key = f"{user_id}:{msg}"
    if cache_key in CACHE:
        return jsonify({"status":"cached","response":CACHE[cache_key]})

    res = await chatbot.get_response(user_id, msg)
    CACHE[cache_key] = res["response"]
    return jsonify(res)

@app.route("/api/user/profile", methods=["POST"])
def save_profile():
    data = request.get_json()
    USER_PROFILES[data["user_id"]] = data
    return jsonify({"status":"saved","profile":data})

@app.route("/api/user/profile/<uid>")
def get_profile(uid):
    return jsonify({"profile":USER_PROFILES.get(uid)})

@app.route("/api/chat/history/<uid>")
def history(uid):
    return jsonify({"history":chatbot.history.get(uid,[])})

@app.route("/api/chat/clear/<uid>", methods=["DELETE"])
def clear(uid):
    chatbot.history.pop(uid,None)
    return jsonify({"status":"cleared"})

@app.route("/api/faq")
def faq():
    return jsonify({
        "faq":[
            "How to donate food? → Go to Donate > Food",
            "Who can receive donations? → NGOs & needy people",
            "Can I track my donation? → Yes in History tab"
        ]
    })

@app.route("/api/feedback", methods=["POST"])
def feedback():
    data = request.get_json()
    FEEDBACKS.append({"user":data["user_id"],"text":data["text"],"time":datetime.now().isoformat()})
    return jsonify({"status":"thanks"})

@app.route("/api/admin/stats")
def stats():
    return jsonify({
        "users":len(chatbot.history),
        "messages":sum(len(v) for v in chatbot.history.values()),
        "profiles":len(USER_PROFILES),
        "feedbacks":len(FEEDBACKS),
        "cache_size":len(CACHE)
    })

# ===============================
# Run
# ===============================

if __name__ == "__main__":
    logger.info("WasteNot Chatbot Running...")
    app.run(host="0.0.0.0", port=5000, debug=False)
