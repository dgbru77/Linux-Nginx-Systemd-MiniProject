#!/bin/bash

LOG_SRC="/var/log/boot-info.log"
WEB_LOG="/var/www/html/boot-info.html"

# Append boot logs
{
  echo "========================"
  echo "System boot time: $(date)"
  echo "Disk Usage:"
  df -h
} >> "$LOG_SRC"

# Generate HTML page
cat <<EOF > "$WEB_LOG"
<!DOCTYPE html>
<html>
<head>
  <title>Linux Boot Automation Logs</title>
  <meta charset="UTF-8">
  <style>
    body {
      font-family: monospace;
      background-color: #0f172a;
      color: #e5e7eb;
      padding: 20px;
    }
    h1 { color: #38bdf8; }
    .info { color: #94a3b8; margin-bottom: 15px; }
    pre {
      background-color: #020617;
      padding: 15px;
      border-radius: 6px;
      overflow-x: auto;
    }
  </style>
</head>
<body>

<h1>Linux Boot Automation Logs</h1>

<div class="info">
  Generated automatically at system boot using a systemd oneshot service.<br>
  Served via NGINX.
</div>

<pre>
EOF

cat "$LOG_SRC" >> "$WEB_LOG"

cat <<EOF >> "$WEB_LOG"
</pre>

</body>
</html>
EOF
