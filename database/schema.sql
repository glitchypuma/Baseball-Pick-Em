-- Users table
CREATE TABLE users (
  id SERIAL PRIMARY KEY,
  username VARCHAR(50) UNIQUE NOT NULL,
  email VARCHAR(100) UNIQUE NOT NULL,
  password_hash VARCHAR(255) NOT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Daily picks table
CREATE TABLE daily_picks (
  id SERIAL PRIMARY KEY,
  user_id INT REFERENCES users(id),
  pick_date DATE NOT NULL,
  category VARCHAR(50) NOT NULL,
  selection VARCHAR(100) NOT NULL,
  result VARCHAR(20),
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Leaderboard table
CREATE TABLE leaderboard (
  id SERIAL PRIMARY KEY,
  user_id INT REFERENCES users(id),
  total_points INT DEFAULT 0,
  correct_picks INT DEFAULT 0,
  total_picks INT DEFAULT 0,
  last_updated TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- CSV import table for baseball statistics
CREATE TABLE baseball_stats (
  id SERIAL PRIMARY KEY,
  player_name VARCHAR(100) NOT NULL,
  team VARCHAR(50),
  position VARCHAR(20),
  stat_date DATE,
  home_runs INT DEFAULT 0,
  hits INT DEFAULT 0,
  rbi INT DEFAULT 0,
  stolen_bases INT DEFAULT 0,
  batting_avg DECIMAL(5,3),
  era DECIMAL(5,2),
  imported_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);