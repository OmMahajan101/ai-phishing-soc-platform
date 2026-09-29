import React, { useState } from 'react';

export default function App() {
  const [telemetry, setTelemetry] = useState([
    { id: 1, type: 'PHISHING_ATTEMPT', url: 'http://login-security-verify-bank.com', score: 0.94, status: 'BLOCKED' },
    { id: 2, type: 'FIM_MUTATION', file: 'fim_sandbox/hosts.conf', action: 'MODIFIED', status: 'ALERT' }
  ]);

  return (
    <div style={{ padding: '2rem', maxWidth: '1200px', margin: '0 auto' }}>
      <header style={{ borderBottom: '1px solid #1e293b', paddingBottom: '1rem', marginBottom: '2rem' }}>
        <h1 style={{ margin: 0, fontSize: '1.8rem', color: '#38bdf8' }}>🛡️ AI Phishing & SOC Intelligence Console</h1>
        <p style={{ color: '#94a3b8', margin: '0.4rem 0 0' }}>Real-time Detection, Brand Impersonation Defense & Host FIM Telemetry</p>
      </header>

      <div style={{ display: 'grid', gridTemplateColumns: 'repeat(auto-fit, minmax(280px, 1fr))', gap: '1.5rem', marginBottom: '2rem' }}>
        <div style={{ background: '#1e293b', padding: '1.5rem', borderRadius: '8px' }}>
          <h3 style={{ margin: '0 0 0.5rem', color: '#94a3b8', fontSize: '0.9rem' }}>ACTIVE PHISHING THREATS</h3>
          <span style={{ fontSize: '2rem', fontWeight: 'bold', color: '#ef4444' }}>14 Detected</span>
        </div>
        <div style={{ background: '#1e293b', padding: '1.5rem', borderRadius: '8px' }}>
          <h3 style={{ margin: '0 0 0.5rem', color: '#94a3b8', fontSize: '0.9rem' }}>FIM SANDBOX INTEGRITY</h3>
          <span style={{ fontSize: '2rem', fontWeight: 'bold', color: '#10b981' }}>Watchdog Active</span>
        </div>
        <div style={{ background: '#1e293b', padding: '1.5rem', borderRadius: '8px' }}>
          <h3 style={{ margin: '0 0 0.5rem', color: '#94a3b8', fontSize: '0.9rem' }}>CHROME EXTENSION SENSORS</h3>
          <span style={{ fontSize: '2rem', fontWeight: 'bold', color: '#3b82f6' }}>Online (v3)</span>
        </div>
      </div>

      <section style={{ background: '#1e293b', padding: '1.5rem', borderRadius: '8px' }}>
        <h2 style={{ margin: '0 0 1rem', fontSize: '1.2rem' }}>Real-Time Security Event Stream</h2>
        <table style={{ width: '100%', borderCollapse: 'collapse', textAlign: 'left', fontSize: '0.9rem' }}>
          <thead>
            <tr style={{ borderBottom: '1px solid #334155', color: '#94a3b8' }}>
              <th style={{ padding: '0.75rem' }}>Event ID</th>
              <th style={{ padding: '0.75rem' }}>Threat Category</th>
              <th style={{ padding: '0.75rem' }}>Target / Artifact</th>
              <th style={{ padding: '0.75rem' }}>Confidence / Status</th>
            </tr>
          </thead>
          <tbody>
            {telemetry.map(item => (
              <tr key={item.id} style={{ borderBottom: '1px solid #283548' }}>
                <td style={{ padding: '0.75rem', fontFamily: 'monospace' }}>#{item.id}</td>
                <td style={{ padding: '0.75rem', color: '#f87171' }}>{item.type}</td>
                <td style={{ padding: '0.75rem', fontFamily: 'monospace', color: '#cbd5e1' }}>{item.url || item.file}</td>
                <td style={{ padding: '0.75rem' }}>
                  <span style={{
                    padding: '3px 8px',
                    borderRadius: '4px',
                    background: item.status === 'BLOCKED' ? 'rgba(239, 68, 68, 0.2)' : 'rgba(245, 158, 11, 0.2)',
                    color: item.status === 'BLOCKED' ? '#f87171' : '#fbbf24',
                    fontSize: '0.8rem',
                    fontWeight: 'bold'
                  }}>
                    {item.status}
                  </span>
                </td>
              </tr>
            ))}
          </tbody>
        </table>
      </section>
    </div>
  );
}
