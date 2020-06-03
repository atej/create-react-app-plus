## Mocking a REST API with Express & Connect API Mocker
### `mock-api/app.js`
```js
const express = require('express');
const apiMocker = require('connect-api-mocker');

const port = 9000;
const app = express();

app.use('/api', apiMocker('mock-api'));

console.log(`Mock API Server is up and running at: http://localhost:${port}`);
app.listen(port);
```
- Refer [this post](https://blog.harveydelaney.com/setting-up-a-mock-api-for-your-front-end-react-project/) for a detailed breakdown of the what and how of this set up
- For more information, refer `connect-api-mocker` [docs](https://github.com/muratcorlu/connect-api-mocker)