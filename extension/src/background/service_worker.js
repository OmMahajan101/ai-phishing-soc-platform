/**
 * AI Phishing Shield - Chrome Extension Manifest V3 Background Service Worker
 * Intercepts tab navigation and queries the FastAPI backend for real-time threat verdicts.
 */

const API_BASE_URL = 'http://localhost:8000';

chrome.tabs.onUpdated.addListener((tabId, changeInfo, tab) => {
  if (changeInfo.status === 'complete' && tab.url && tab.url.startsWith('http')) {
    evaluateUrl(tab.url, tabId);
  }
});

async function evaluateUrl(url, tabId) {
  try {
    const response = await fetch(`${API_BASE_URL}/api/v1/phishing/analyze`, {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify({ url })
    });

    if (response.ok) {
      const result = await response.json();
      if (result.is_phishing) {
        chrome.action.setBadgeText({ tabId, text: 'ALERT' });
        chrome.action.setBadgeBackgroundColor({ tabId, color: '#DC2626' });

        // Notify content script to display security overlay
        chrome.tabs.sendMessage(tabId, {
          action: 'PHISHING_WARNING',
          verdict: result
        }).catch(() => {});
      } else {
        chrome.action.setBadgeText({ tabId, text: 'SAFE' });
        chrome.action.setBadgeBackgroundColor({ tabId, color: '#10B981' });
      }
    }
  } catch (error) {
    console.debug('[AI Phishing Sensor] Backend offline or unreachable:', error.message);
  }
}
