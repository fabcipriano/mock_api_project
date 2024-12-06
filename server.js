const express = require('express');
const app = express();
const port = 3000;

// Middleware to parse JSON request bodies
app.use(express.json());

// Middleware to enforce Content-Type header
app.use((req, res, next) => {
  const contentType = req.headers['content-type'];
  if (!contentType) {
    return res.status(400).json({ error: 'Missing Content-Type header' });
  }
  if (contentType !== 'application/json') {
    return res.status(400).json({ error: 'Content-Type must be application/json' });
  }
  next();
});

// Middleware to log all HTTP requests
app.use((req, res, next) => {
  console.log('--- Incoming Request ---');
  console.log(`Method: ${req.method}`);
  console.log(`URL: ${req.originalUrl}`);
  console.log('Headers:', req.headers);
  console.log('Query Parameters:', req.query);
  console.log('Body:', req.body);

  // Capture the response details
  const originalSend = res.send;
  res.send = function (body) {
    console.log('--- Response ---');
    console.log('Status Code:', res.statusCode);
    console.log('Response Headers:', res.getHeaders());
    console.log('Response Body:', body);
    originalSend.call(this, body);
  };
  next();
});

// Hardcoded data
const customersData = [
  {
    id: 28210,
    typeId: "4bd2f2c5-2a1d-4977-b50d-c858f9019a83",
    typeName: "Telefonia móvel",
    attributes: {
      ddd: "11",
      imei: "3987e457b44b179c",
      msisdn: "5511914810095",
      storeFlow: "FALSE",
      isEmployee: false,
      appsflyerId: "1733251645899-1046529223769090535",
      migrationType: "PRE_PAGO",
      activationType: "MIGRATION",
      chipSimDelivery: "FALSE",
      activationChannel: "Android",
    },
    externalId: "JOIN-a8f0f883-5e9c-40d6-98e3-7b7800586159",
    foreignLabel: "5511914810095",
    foreignId: "2140519",
    activationDate: "2024-12-03T20:12:46.109",
    status: "ACTIVE",
    createdAt: "2024-12-03T20:05:03.972",
    updatedAt: "2024-12-03T20:12:46.148",
    inactivationDate: null,
    inactivationReason: null,
    inactivatedBy: null,
    inactivatingDate: null,
    inactivatingReason: null,
    inactivatingBy: null,
  },
  {
    id: 28202,
    typeId: "4bd2f2c5-2a1d-4977-b50d-c858f9019a83",
    typeName: "Telefonia móvel",
    attributes: {
      ddd: "11",
      imei: "3987e457b44b179c",
      msisdn: "5511914810095",
      storeFlow: "FALSE",
      isEmployee: false,
      appsflyerId: "1733143296872-2378089023862476048",
      migrationType: "PRE_PAGO",
      activationType: "MIGRATION",
      chipSimDelivery: "FALSE",
      activationChannel: "Android",
    },
    externalId: "JOIN-6eedaa82-3757-4adb-b66d-a65a46c5f622",
    foreignLabel: null,
    foreignId: "2140216",
    activationDate: "2024-12-02T20:33:23.045",
    status: "INACTIVE",
    createdAt: "2024-12-02T20:32:30.576",
    updatedAt: "2024-12-03T19:30:19.747",
    inactivationDate: "2024-12-03T19:30:19.711",
    inactivationReason: "PREPAID",
    inactivatedBy: "EXT-Inativar produto RW-0811889c-b1ad-11ef-8a5b-3280dabf9318",
    inactivatingDate: "2024-12-03T17:42:37.780",
    inactivatingReason: "Digital Attendance",
    inactivatingBy: "CSP",
  },
];

// Define the route
app.get('/customers', (req, res) => {
  const customerId = req.query.id;
  // Check if the id matches the hardcoded value
  if (customerId === 'abc-123-def') {
    res.json(customersData);
  } else {
    res.status(404).json({ error: 'Customer not found' });
  }
});

// Start the server
app.listen(port, () => {
  console.log(`Mock API server is running at http://localhost:${port}`);
});