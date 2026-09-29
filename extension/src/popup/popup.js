document.addEventListener('DOMContentLoaded', async () => {
  const urlDisplay = document.getElementById('current-url');
  const btnScan = document.getElementById('btn-scan');

  const [tab] = await chrome.tabs.query({ active: true, currentWindow: true });
  if (tab && tab.url) {
    urlDisplay.textContent = tab.url;
  }

  btnScan.addEventListener('click', async () => {
    btnScan.textContent = 'Scanning...';
    btnScan.disabled = true;

    setTimeout(() => {
      btnScan.textContent = 'Re-Scan Active Tab';
      btnScan.disabled = false;
    }, 1200);
  });
});
