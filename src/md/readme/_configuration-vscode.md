## Auto-fix in Visual Studio Code
### `.vscode/settings.json`
- eslint extension settings
- emmet support in jsx
```json
{
  "eslint.packageManager": (SET BY USER),
  "eslint.format.enable": true,
  "editor.defaultFormatter": "dbaeumer.vscode-eslint",
  "editor.formatOnPaste": true,
  "editor.formatOnSave": true,
  "emmet.includeLanguages": {
    "javascript": "javascriptreact"
  }
}
```
- **IMPORTANT**: This [ESLint extension](https://marketplace.visualstudio.com/items?itemName=dbaeumer.vscode-eslint) mast be installed and enabled in your workspace. 
- **Disable** the VS Code **Prettier** plugin in your workspace, if you have it enabled. Code will be both auto-formatted and auto-linted on save by the ESLint extension.