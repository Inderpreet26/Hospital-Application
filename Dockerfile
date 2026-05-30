FROM node:18-alpine

WORKDIR /app

# Install backend deps first (better layer caching)
COPY backend/package*.json ./backend/
RUN cd backend && npm install --omit=dev

# Copy the rest of the repo (backend code + public frontend)
COPY . .

# Run from backend so __dirname/../public points at /app/public
WORKDIR /app/backend

EXPOSE 5000
CMD ["node", "app.js"]