:root {
  --bg: #fff;
  --text: #333;
  --card: #f2f2f2;
}
.dark {
  --bg: #333;
  --text: #eee;
  --card: #444;
}

* { box-sizing: border-box; }
body {
  margin: 0;
  font-family: sans-serif;
  background: var(--bg);
  color: var(--text);
}
.container {
  max-width: 600px;
  margin: 0 auto;
  padding: 20px;
}
header {
  display: flex;
  justify-content: space-between;
  align-items: center;
}
button {
  padding: 8px 12px;
  font-size: 16px;
  cursor: pointer;
}
input {
  padding: 8px;
  font-size: 16px;
}
.create-alarm {
  margin: 20px 0;
}
#alarmsList {
  list-style: none;
  padding: 0;
}
.alarm-card {
  background: var(--card);
  padding: 15px;
  margin-bottom: 10px;
  border-radius: 5px;
  display: flex;
  justify-content: space-between;
  align-items: center;
}
.alarm-info {
  display: flex;
  flex-direction: column;
}
.alarm-controls button {
  margin-left: 5px;
}
