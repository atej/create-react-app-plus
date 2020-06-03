# Adding eslint rule to index.js
sed -i.bak '1i\
/* eslint-disable react/jsx-filename-extension */
' src/index.js
rm src/index.js.bak