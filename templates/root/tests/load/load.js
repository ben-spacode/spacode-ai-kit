// k6 load test — runs against staging before every promotion to main.
// Set the expected peak in PEAK_VUS (GitHub Environment variable) per project.
import http from 'k6/http';
import { check, sleep } from 'k6';

const BASE = __ENV.BASE_URL;
const PEAK = Number(__ENV.PEAK_VUS || 50);

export const options = {
  stages: [
    { duration: '2m', target: Math.round(PEAK / 2) },
    { duration: '5m', target: PEAK },
    { duration: '2m', target: Math.round(PEAK * 1.5) }, // stress above expected peak
    { duration: '1m', target: 0 },
  ],
  thresholds: {
    http_req_failed: ['rate<0.01'],
    http_req_duration: ['p(95)<500', 'p(99)<1500'],
  },
};

export default function () {
  const res = http.get(`${BASE}/health/ready`);
  check(res, { 'status 200': (r) => r.status === 200 });
  // TODO(project): realistic journeys with a dedicated load-test tenant (never production data)
  sleep(1);
}
