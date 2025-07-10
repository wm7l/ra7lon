const alarmsList = document.getElementById('alarmsList');
const addAlarmBtn = document.getElementById('addAlarmBtn');
const nameInput = document.getElementById('alarmName');
const resetAllBtn = document.getElementById('resetAllBtn');
const modeToggle = document.getElementById('modeToggle');
const alarmSound = document.getElementById('alarmSound');

let alarms = [];

function addAlarm(name) {
  const duration = 22 * 60;
  const alarm = {
    id: Date.now(),
    name,
    remaining: duration,
    intervalId: null,
  };
  alarms.push(alarm);
  renderAlarm(alarm);
}

function renderAlarm(alarm) {
  const li = document.createElement('li');
  li.className = 'alarm-card';
  li.id = `alarm-${alarm.id}`;
  li.innerHTML = `
    <div class="alarm-info">
      <strong>${alarm.name}</strong>
      <span id="time-${alarm.id}">${formatTime(alarm.remaining)}</span>
    </div>
    <div class="alarm-controls">
      <button onclick="startAlarm(${alarm.id})">▶️ Start</button>
      <button onclick="stopAlarm(${alarm.id})">⏹ Stop</button>
      <button onclick="removeAlarm(${alarm.id})">🗑 Remove</button>
    </div>`;
  alarmsList.appendChild(li);
}

function updateTime(alarm) {
  const span = document.getElementById(`time-${alarm.id}`);
  if (span) span.textContent = formatTime(alarm.remaining);
}

function startAlarm(id) {
  const alarm = alarms.find(a => a.id === id);
  if (!alarm || alarm.intervalId) return;
  alarm.intervalId = setInterval(() => {
    alarm.remaining--;
    updateTime(alarm);
    if (alarm.remaining < 0) {
      clearInterval(alarm.intervalId);
      alarm.intervalId = null;
      document.getElementById(`alarm-${id}`).querySelector('span').textContent = `${alarm.name} انتهى!`;
      alarmSound.play();
    }
  }, 1000);
}

function stopAlarm(id) {
  const alarm = alarms.find(a => a.id === id);
  if (alarm && alarm.intervalId) {
    clearInterval(alarm.intervalId);
    alarm.intervalId = null;
  }
}

function removeAlarm(id) {
  stopAlarm(id);
  alarms = alarms.filter(a => a.id !== id);
  const el = document.getElementById(`alarm-${id}`);
  if (el) el.remove();
}

function resetAll() {
  alarms.forEach(a => {
    stopAlarm(a.id);
    a.remaining = 22 * 60;
    updateTime(a);
  });
}

function formatTime(sec) {
  const m = Math.floor(Math.max(sec, 0) / 60);
  const s = Math.max(sec, 0) % 60;
  return `${String(m).padStart(2,'0')}:${String(s).padStart(2,'0')}`;
}

modeToggle.addEventListener('click', () => {
  document.body.classList.toggle('dark');
  modeToggle.textContent = document.body.classList.contains('dark') ? '☀️ Light Mode' : '🌙 Dark Mode';
});

addAlarmBtn.addEventListener('click', () => {
  const name = nameInput.value.trim() || 'منبه';
  addAlarm(name);
  nameInput.value = '';
});

resetAllBtn.addEventListener('click', resetAll);
