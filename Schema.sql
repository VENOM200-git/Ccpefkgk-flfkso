-- Table: posts
CREATE TABLE IF NOT EXISTS posts (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  media_url text NOT NULL,
  caption text,
  type text CHECK (type IN ('image', 'video', 'text')) DEFAULT 'image',
  created_at timestamp with time zone DEFAULT timezone('utc'::text, now()),
  views int DEFAULT 0
);

-- Table: likes
CREATE TABLE IF NOT EXISTS likes (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  post_id uuid REFERENCES posts(id) ON DELETE CASCADE,
  user_id text,
  created_at timestamp with time zone DEFAULT timezone('utc'::text, now())
);

-- Table: comments
CREATE TABLE IF NOT EXISTS comments (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  post_id uuid REFERENCES posts(id) ON DELETE CASCADE,
  user_id text,
  content text NOT NULL,
  created_at timestamp with time zone DEFAULT timezone('utc'::text, now())
);

-- Table: reactions (to comments)
CREATE TABLE IF NOT EXISTS reactions (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  comment_id uuid REFERENCES comments(id) ON DELETE CASCADE,
  user_id text,
  emoji text CHECK (emoji IN ('😭', '🤣', '😡')),
  created_at timestamp with time zone DEFAULT timezone('utc'::text, now())
);

-- Table: messages (for chat)
CREATE TABLE IF NOT EXISTS messages (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id text,
  content text,
  created_at timestamp with time zone DEFAULT timezone('utc'::text, now())
);
