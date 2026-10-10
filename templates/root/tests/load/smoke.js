// k6 smoke load — runs in the full level on development/staging.
import http from 'k6/http';
import { check, sleep } from 'k6';

const BASE = __ENV.BASE_URL;

export const options = {
  vus: 5,
  duration: '1m',
  thresholds: {
    http_req_failed: ['rate<0.01'],
    http_req_duration: ['p(95)<500'],
  },
};

export default function () {
  const res = http.get(`${BASE}/health/ready`);
  check(res, { 'status 200': (r) => r.status === 200 });
  // TODO(project): add key read-only endpoints, e.g. public catalog / pricing
  sleep(1);
}
