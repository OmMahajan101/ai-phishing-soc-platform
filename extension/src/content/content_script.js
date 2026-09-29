/**
 * AI Phishing Shield - Content Script
 * Inspects DOM elements (forms, password inputs, external links) and injects warning banners when malicious.
 */

chrome.runtime.onMessage.addListener((message, sender, sendResponse) => {
  if (message.action === 'PHISHING_WARNING') {
    injectSecurityBanner(message.verdict);
    sendResponse({ received: true });
  }
});

function injectSecurityBanner(verdict) {
  if (document.getElementById('ai-phishing-shield-banner')) return;

  const banner = document.createElement('div');
  banner.id = 'ai-phishing-shield-banner';
  banner.style.cssText = `
    position: fixed;
    top: 0;
    left: 0;
    width: 100%;
    background: linear-gradient(135deg, #b91c1c, #7f1d1d);
    color: #ffffff;
    padding: 16px 24px;
    z-index: 2147483647;
    font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, sans-serif;
    box-shadow: 0 4px 20px rgba(0,0,0,0.5);
    display: flex;
    justify-content: space-between;
    align-items: center;
  `;

  banner.innerHTML = `
    <div>
      <strong style="font-size: 16px; display: block; margin-bottom: 4px;">⚠️ WARNING: Potential AI Phishing Threat Detected!</strong>
      <span style="font-size: 13px; opacity: 0.9;">Confidence Score: ${(verdict.confidence * 100).toFixed(1)}% | Flagged by SOC Platform Security Sensors</span>
    </div>
    <div>
      <button id="ai-shield-proceed" style="background: rgba(255,255,255,0.2); border: 1px solid rgba(255,255,255,0.4); color: white; padding: 6px 14px; border-radius: 4px; cursor: pointer; margin-right: 8px;">Dismiss</button>
      <button id="ai-shield-leave" style="background: white; border: none; color: #991b1b; padding: 6px 14px; border-radius: 4px; font-weight: bold; cursor: pointer;">Leave Site</button>
    </div>
  `;

  document.body.prepend(banner);

  document.getElementById('ai-shield-proceed').addEventListener('click', () => banner.remove());
  document.getElementById('ai-shield-leave').addEventListener('click', () => window.location.href = 'about:blank');
}
