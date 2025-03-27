[1mdiff --git a/frontend_LHB3/.gitignore b/frontend_LHB3/.gitignore[m
[1mnew file mode 100644[m
[1mindex 0000000..a547bf3[m
[1m--- /dev/null[m
[1m+++ b/frontend_LHB3/.gitignore[m
[36m@@ -0,0 +1,24 @@[m
[32m+[m[32m# Logs[m
[32m+[m[32mlogs[m
[32m+[m[32m*.log[m
[32m+[m[32mnpm-debug.log*[m
[32m+[m[32myarn-debug.log*[m
[32m+[m[32myarn-error.log*[m
[32m+[m[32mpnpm-debug.log*[m
[32m+[m[32mlerna-debug.log*[m
[32m+[m
[32m+[m[32mnode_modules[m
[32m+[m[32mdist[m
[32m+[m[32mdist-ssr[m
[32m+[m[32m*.local[m
[32m+[m
[32m+[m[32m# Editor directories and files[m
[32m+[m[32m.vscode/*[m
[32m+[m[32m!.vscode/extensions.json[m
[32m+[m[32m.idea[m
[32m+[m[32m.DS_Store[m
[32m+[m[32m*.suo[m
[32m+[m[32m*.ntvs*[m
[32m+[m[32m*.njsproj[m
[32m+[m[32m*.sln[m
[32m+[m[32m*.sw?[m
[1mdiff --git a/frontend_LHB3/README.md b/frontend_LHB3/README.md[m
[1mnew file mode 100644[m
[1mindex 0000000..fd3b758[m
[1m--- /dev/null[m
[1m+++ b/frontend_LHB3/README.md[m
[36m@@ -0,0 +1,12 @@[m
[32m+[m[32m# React + Vite[m
[32m+[m
[32m+[m[32mThis template provides a minimal setup to get React working in Vite with HMR and some ESLint rules.[m
[32m+[m
[32m+[m[32mCurrently, two official plugins are available:[m
[32m+[m
[32m+[m[32m- [@vitejs/plugin-react](https://github.com/vitejs/vite-plugin-react/blob/main/packages/plugin-react/README.md) uses [Babel](https://babeljs.io/) for Fast Refresh[m
[32m+[m[32m- [@vitejs/plugin-react-swc](https://github.com/vitejs/vite-plugin-react-swc) uses [SWC](https://swc.rs/) for Fast Refresh[m
[32m+[m
[32m+[m[32m## Expanding the ESLint configuration[m
[32m+[m
[32m+[m[32mIf you are developing a production application, we recommend using TypeScript and enable type-aware lint rules. Check out the [TS template](https://github.com/vitejs/vite/tree/main/packages/create-vite/template-react-ts) to integrate TypeScript and [`typescript-eslint`](https://typescript-eslint.io) in your project.[m
[1mdiff --git a/frontend_LHB3/eslint.config.js b/frontend_LHB3/eslint.config.js[m
[1mnew file mode 100644[m
[1mindex 0000000..ec2b712[m
[1m--- /dev/null[m
[1m+++ b/frontend_LHB3/eslint.config.js[m
[36m@@ -0,0 +1,33 @@[m
[32m+[m[32mimport js from '@eslint/js'[m
[32m+[m[32mimport globals from 'globals'[m
[32m+[m[32mimport reactHooks from 'eslint-plugin-react-hooks'[m
[32m+[m[32mimport reactRefresh from 'eslint-plugin-react-refresh'[m
[32m+[m
[32m+[m[32mexport default [[m
[32m+[m[32m  { ignores: ['dist'] },[m
[32m+[m[32m  {[m
[32m+[m[32m    files: ['**/*.{js,jsx}'],[m
[32m+[m[32m    languageOptions: {[m
[32m+[m[32m      ecmaVersion: 2020,[m
[32m+[m[32m      globals: globals.browser,[m
[32m+[m[32m      parserOptions: {[m
[32m+[m[32m        ecmaVersion: 'latest',[m
[32m+[m[32m        ecmaFeatures: { jsx: true },[m
[32m+[m[32m        sourceType: 'module',[m
[32m+[m[32m      },[m
[32m+[m[32m    },[m
[32m+[m[32m    plugins: {[m
[32m+[m[32m      'react-hooks': reactHooks,[m
[32m+[m[32m      'react-refresh': reactRefresh,[m
[32m+[m[32m    },[m
[32m+[m[32m    rules: {[m
[32m+[m[32m      ...js.configs.recommended.rules,[m
[32m+[m[32m      ...reactHooks.configs.recommended.rules,[m
[32m+[m[32m      'no-unused-vars': ['error', { varsIgnorePattern: '^[A-Z_]' }],[m
[32m+[m[32m      'react-refresh/only-export-components': [[m
[32m+[m[32m        'warn',[m
[32m+[m[32m        { allowConstantExport: true },[m
[32m+[m[32m      ],[m
[32m+[m[32m    },[m
[32m+[m[32m  },[m
[32m+[m[32m][m
[1mdiff --git a/frontend_LHB3/index.html b/frontend_LHB3/index.html[m
[1mnew file mode 100644[m
[1mindex 0000000..fff3bde[m
[1m--- /dev/null[m
[1m+++ b/frontend_LHB3/index.html[m
[36m@@ -0,0 +1,13 @@[m
[32m+[m[32m<!doctype html>[m
[32m+[m[32m<html lang="en">[m
[32m+[m[32m  <head>[m
[32m+[m[32m    <meta charset="UTF-8" />[m
[32m+[m[32m    <link rel="icon" type="image/svg+xml" href="/vite.svg" />[m
[32m+[m[32m    <meta name="viewport" content="width=device-width, initial-scale=1.0" />[m
[32m+[m[32m    <title>Lecture Hall Booking Portal</title>[m
[32m+[m[32m  </head>[m
[32m+[m[32m  <body>[m
[32m+[m[32m    <div id="root"></div>[m
[32m+[m[32m    <script type="module" src="/src/main.jsx"></script>[m
[32m+[m[32m  </body>[m
[32m+[m[32m</html>[m
[1mdiff --git a/frontend_LHB3/package-lock.json b/frontend_LHB3/package-lock.json[m
[1mnew file mode 100644[m
[1mindex 0000000..0154755[m
[1m--- /dev/null[m
[1m+++ b/frontend_LHB3/package-lock.json[m
[36m@@ -0,0 +1,3532 @@[m
[32m+[m[32m{[m
[32m+[m[32m  "name": "frontend_lhb3",[m
[32m+[m[32m  "version": "0.0.0",[m
[32m+[m[32m  "lockfileVersion": 3,[m
[32m+[m[32m  "requires": true,[m
[32m+[m[32m  "packages": {[m
[32m+[m[32m    "": {[m
[32m+[m[32m      "name": "frontend_lhb3",[m
[32m+[m[32m      "version": "0.0.0",[m
[32m+[m[32m      "dependencies": {[m
[32m+[m[32m        "@tailwindcss/vite": "^4.0.15",[m
[32m+[m[32m        "axios": "^1.8.4",[m
[32m+[m[32m        "react": "^19.0.0",[m
[32m+[m[32m        "react-dom": "^19.0.0",[m
[32m+[m[32m        "react-router-dom": "^7.4.0",[m
[32m+[m[32m        "tailwindcss": "^4.0.15"[m
[32m+[m[32m      },[m
[32m+[m[32m      "devDependencies": {[m
[32m+[m[32m        "@eslint/js": "^9.21.0",[m
[32m+[m[32m        "@types/react": "^19.0.10",[m
[32m+[m[32m        "@types/react-dom": "^19.0.4",[m
[32m+[m[32m        "@vitejs/plugin-react": "^4.3.4",[m
[32m+[m[32m        "eslint": "^9.21.0",[m
[32m+[m[32m        "eslint-plugin-react-hooks": "^5.1.0",[m
[32m+[m[32m        "eslint-plugin-react-refresh": "^0.4.19",[m
[32m+[m[32m        "globals": "^15.15.0",[m
[32m+[m[32m        "vite": "^6.2.0"[m
[32m+[m[32m      }[m
[32m+[m[32m    },[m
[32m+[m[32m    "node_modules/@ampproject/remapping": {[m
[32m+[m[32m      "version": "2.3.0",[m
[32m+[m[32m      "resolved": "https://registry.npmjs.org/@ampproject/remapping/-/remapping-2.3.0.tgz",[m
[32m+[m[32m      "integrity": "sha512-30iZtAPgz+LTIYoeivqYo853f02jBYSd5uGnGpkFV0M3xOt9aN73erkgYAmZU43x4VfqcnLxW9Kpg3R5LC4YYw==",[m
[32m+[m[32m      "dev": true,[m
[32m+[m[32m      "license": "Apache-2.0",[m
[32m+[m[32m      "dependencies": {[m
[32m+[m[32m        "@jridgewell/gen-mapping": "^0.3.5",[m
[32m+[m[32m        "@jridgewell/trace-mapping": "^0.3.24"[m
[32m+[m[32m      },[m
[32m+[m[32m      "engines": {[m
[32m+[m[32m        "node": ">=6.0.0"[m
[32m+[m[32m      }[m
[32m+[m[32m    },[m
[32m+[m[32m    "node_modules/@babel/code-frame": {[m
[32m+[m[32m      "version": "7.26.2",[m
[32m+[m[32m      "resolved": "https://registry.npmjs.org/@babel/code-frame/-/code-frame-7.26.2.tgz",[m
[32m+[m[32m      "integrity": "sha512-RJlIHRueQgwWitWgF8OdFYGZX328Ax5BCemNGlqHfplnRT9ESi8JkFlvaVYbS+UubVY6dpv87Fs2u5M29iNFVQ==",[m
[32m+[m[32m      "dev": true,[m
[32m+[m[32m      "license": "MIT",[m
[32m+[m[32m      "dependencies": {[m
[32m+[m[32m        "@babel/helper-validator-identifier": "^7.25.9",[m
[32m+[m[32m        "js-tokens": "^4.0.0",[m
[32m+[m[32m        "picocolors": "^1.0.0"[m
[32m+[m[32m      },[m
[32m+[m[32m      "engines": {[m
[32m+[m[32m        "node": ">=6.9.0"[m
[32m+[m[32m      }[m
[32m+[m[32m    },[m
[32m+[m[32m    "node_modules/@babel/compat-data": {[m
[32m+[m[32m      "version": "7.26.8",[m
[32m+[m[32m      "resolved": "https://registry.npmjs.org/@babel/compat-data/-/compat-data-7.26.8.tgz",[m
[32m+[m[32m      "integrity": "sha512-oH5UPLMWR3L2wEFLnFJ1TZXqHufiTKAiLfqw5zkhS4dKXLJ10yVztfil/twG8EDTA4F/tvVNw9nOl4ZMslB8rQ==",[m
[32m+[m[32m      "dev": true,[m
[32m+[m[32m      "license": "MIT",[m
[32m+[m[32m      "engines": {[m
[32m+[m[32m        "node": ">=6.9.0"[m
[32m+[m[32m      }[m
[32m+[m[32m    },[m
[32m+[m[32m    "node_modules/@babel/core": {[m
[32m+[m[32m      "version": "7.26.10",[m
[32m+[m[32m      "resolved": "https://registry.npmjs.org/@babel/core/-/core-7.26.10.tgz",[m
[32m+[m[32m      "integrity": "sha512-vMqyb7XCDMPvJFFOaT9kxtiRh42GwlZEg1/uIgtZshS5a/8OaduUfCi7kynKgc3Tw/6Uo2D+db9qBttghhmxwQ==",[m
[32m+[m[32m      "dev": true,[m
[32m+[m[32m      "license": "MIT",[m
[32m+[m[32m      "dependencies": {[m
[32m+[m[32m        "@ampproject/remapping": "^2.2.0",[m
[32m+[m[32m        "@babel/code-frame": "^7.26.2",[m
[32m+[m[32m        "@babel/generator": "^7.26.10",[m
[32m+[m[32m        "@babel/helper-compilation-targets": "^7.26.5",[m
[32m+[m[32m        "@babel/helper-module-transforms": "^7.26.0",[m
[32m+[m[32m        "@babel/helpers": "^7.26.10",[m
[32m+[m[32m        "@babel/parser": "^7.26.10",[m
[32m+[m[32m        "@babel/template": "^7.26.9",[m
[32m+[m[32m        "@babel/traverse": "^7.26.10",[m
[32m+[m[32m        "@babel/types": "^7.26.10",[m
[32m+[m[32m        "convert-source-map": "^2.0.0",[m
[32m+[m[32m        "debug": "^4.1.0",[m
[32m+[m[32m        "gensync": "^1.0.0-beta.2",[m
[32m+[m[32m        "json5": "^2.2.3",[m
[32m+[m[32m        "semver": "^6.3.1"[m
[32m+[m[32m      },[m
[32m+[m[32m      "engines": {[m
[32m+[m[32m        "node": ">=6.9.0"[m
[32m+[m[32m      },[m
[32m+[m[32m      "funding": {[m
[32m+[m[32m        "type": "opencollective",[m
[32m+[m[32m        "url": "https://opencollective.com/babel"[m
[32m+[m[32m      }[m
[32m+[m[32m    },[m
[32m+[m[32m    "node_modules/@babel/generator": {[m
[32m+[m[32m      "version": "7.26.10",[m
[32m+[m[32m      "resolved": "https://registry.npmjs.org/@babel/generator/-/generator-7.26.10.tgz",[m
[32m+[m[32m      "integrity": "sha512-rRHT8siFIXQrAYOYqZQVsAr8vJ+cBNqcVAY6m5V8/4QqzaPl+zDBe6cLEPRDuNOUf3ww8RfJVlOyQMoSI+5Ang==",[m
[32m+[m[32m      "dev": true,[m
[32m+[m[32m      "license": "MIT",[m
[32m+[m[32m      "dependencies": {[m
[32m+[m[32m        "@babel/parser": "^7.26.10",[m
[32m+[m[32m        "@babel/types": "^7.26.10",[m
[32m+[m[32m        "@jridgewell/gen-mapping": "^0.3.5",[m
[32m+[m[32m        "@jridgewell/trace-mapping": "^0.3.25",[m
[32m+[m[32m        "jsesc": "^3.0.2"[m
[32m+[m[32m      },[m
[32m+[m[32m      "engines": {[m
[32m+[m[32m        "node": ">=6.9.0"[m
[32m+[m[32m      }[m
[32m+[m[32m    },[m
[32m+[m[32m    "node_modules/@babel/helper-compilation-targets": {[m
[32m+[m[32m      "version": "7.26.5",[m
[32m+[m[32m      "resolved": "https://registry.npmjs.org/@babel/helper-compilation-targets/-/helper-compilation-targets-7.26.5.tgz",[m
[32m+[m[32m      "integrity": "sha512-IXuyn5EkouFJscIDuFF5EsiSolseme1s0CZB+QxVugqJLYmKdxI1VfIBOst0SUu4rnk2Z7kqTwmoO1lp3HIfnA==",[m
[32m+[m[32m      "dev": true,[m
[32m+[m[32m      "license": "MIT",[m
[32m+[m[32m      "dependencies": {[m
[32m+[m[32m        "@babel/compat-data": "^7.26.5",[m
[32m+[m[32m        "@babel/helper-validator-option": "^7.25.9",[m
[32m+[m[32m        "browserslist": "^4.24.0",[m
[32m+[m[32m        "lru-cache": "^5.1.1",[m
[32m+[m[32m        "semver": "^6.3.1"[m
[32m+[m[32m      },[m
[32m+[m[32m      "engines": {[m
[32m+[m[32m        "node": ">=6.9.0"[m
[32m+[m[32m      }[m
[32m+[m[32m    },[m
[32m+[m[32m    "node_modules/@babel/helper-module-imports": {[m
[32m+[m[32m      "version": "7.25.9",[m
[32m+[m[32m      "resolved": "https://registry.npmjs.org/@babel/helper-module-imports/-/helper-module-imports-7.25.9.tgz",[m
[32m+[m[32m      "integrity": "sha512-tnUA4RsrmflIM6W6RFTLFSXITtl0wKjgpnLgXyowocVPrbYrLUXSBXDgTs8BlbmIzIdlBySRQjINYs2BAkiLtw==",[m
[32m+[m[32m      "dev": true,[m
[32m+[m[32m      "license": "MIT",[m
[32m+[m[32m      "dependencies": {[m
[32m+[m[32m        "@babel/traverse": "^7.25.9",[m
[32m+[m[32m        "@babel/types": "^7.25.9"[m
[32m+[m[32m      },[m
[32m+[m[32m      "engines": {[m
[32m+[m[32m        "node": ">=6.9.0"[m
[32m+[m[32m      }[m
[32m+[m[32m    },[m
[32m+[m[32m    "node_modules/@babel/helper-module-transforms": {[m
[32m+[m[32m      "version": "7.26.0",[m
[32m+[m[32m      "resolved": "https://registry.npmjs.org/@babel/helper-module-transforms/-/helper-module-transforms-7.26.0.tgz",[m
[32m+[m[32m      "integrity": "sha512-xO+xu6B5K2czEnQye6BHA7DolFFmS3LB7stHZFaOLb1pAwO1HWLS8fXA+eh0A2yIvltPVmx3eNNDBJA2SLHXFw==",[m
[32m+[m[32m      "dev": true,[m
[32m+[m[32m      "license": "MIT",[m
[32m+[m[32m      "dependencies": {[m
[32m+[m[32m        "@babel/helper-module-imports": "^7.25.9",[m
[32m+[m[32m        "@babel/helper-validator-identifier": "^7.25.9",[m
[32m+[m[32m        "@babel/traverse": "^7.25.9"[m
[32m+[m[32m      },[m
[32m+[m[32m      "engines": {[m
[32m+[m[32m        "node": ">=6.9.0"[m
[32m+[m[32m      },[m
[32m+[m[32m      "peerDependencies": {[m
[32m+[m[32m        "@babel/core": "^7.0.0"[m
[32m+[m[32m      }[m
[32m+[m[32m    },[m
[32m+[m[32m    "node_modules/@babel/helper-plugin-utils": {[m
[32m+[m[32m      "version": "7.26.5",[m
[32m+[m[32m      "resolved": "https://registry.npmjs.org/@babel/helper-plugin-utils/-/helper-plugin-utils-7.26.5.tgz",[m
[32m+[m[32m      "integrity": "sha512-RS+jZcRdZdRFzMyr+wcsaqOmld1/EqTghfaBGQQd/WnRdzdlvSZ//kF7U8VQTxf1ynZ4cjUcYgjVGx13ewNPMg==",[m
[32m+[m[32m      "dev": true,[m
[32m+[m[32m      "license": "MIT",[m
[32m+[m[32m      "engines": {[m
[32m+[m[32m        "node": ">=6.9.0"[m
[32m+[m[32m      }[m
[32m+[m[32m    },[m
[32m+[m[32m    "node_modules/@babel/helper-string-parser": {[m
[32m+[m[32m      "version": "7.25.9",[m
[32m+[m[32m      "resolved": "https://registry.npmjs.org/@babel/helper-string-parser/-/helper-string-parser-7.25.9.tgz",[m
[32m+[m[32m      "integrity": "sha512-4A/SCr/2KLd5jrtOMFzaKjVtAei3+2r/NChoBNoZ3EyP/+GlhoaEGoWOZUmFmoITP7zOJyHIMm+DYRd8o3PvHA==",[m
[32m+[m[32m      "dev": true,[m
[32m+[m[32m      "license": "MIT",[m
[32m+[m[32m      "engines": {[m
[32m+[m[32m        "node": ">=6.9.0"[m
[32m+[m[32m      }[m
[32m+[m[32m    },[m
[32m+[m[32m    "node_modules/@babel/helper-validator-identifier": {[m
[32m+[m[32m      "version": "7.25.9",[m
[32m+[m[32m      "resolved": "https://registry.npmjs.org/@babel/helper-validator-identifier/-/helper-validator-identifier-7.25.9.tgz",[m
[32m+[m[32m      "integrity": "sha512-Ed61U6XJc3CVRfkERJWDz4dJwKe7iLmmJsbOGu9wSloNSFttHV0I8g6UAgb7qnK5ly5bGLPd4oXZlxCdANBOWQ==",[m
[32m+[m[32m      "dev": true,[m
[32m+[m[32m      "license": "MIT",[m
[32m+[m[32m      "engines": {[m
[32m+[m[32m        "node": ">=6.9.0"[m
[32m+[m[32m      }[m
[32m+[m[32m    },[m
[32m+[m[32m    "node_modules/@babel/helper-validator-option": {[m
[32m+[m[32m      "version": "7.25.9",[m
[32m+[m[32m      "resolved": "https://registry.npmjs.org/@babel/helper-validator-option/-/helper-validator-option-7.25.9.tgz",[m
[32m+[m[32m      "integrity": "sha512-e/zv1co8pp55dNdEcCynfj9X7nyUKUXoUEwfXqaZt0omVOmDe9oOTdKStH4GmAw6zxMFs50ZayuMfHDKlO7Tfw==",[m
[32m+[m[32m      "dev": true,[m
[32m+[m[32m      "license": "MIT",[m
[32m+[m[32m      "engines": {[m
[32m+[m[32m        "node": ">=6.9.0"[m
[32m+[m[32m      }[m
[32m+[m[32m    },[m
[32m+[m[32m    "node_modules/@babel/helpers": {[m
[32m+[m[32m      "version": "7.26.10",[m
[32m+[m[32m      "resolved": "https://registry.npmjs.org/@babel/helpers/-/helpers-7.26.10.tgz",[m
[32m+[m[32m      "integrity": "sha512-UPYc3SauzZ3JGgj87GgZ89JVdC5dj0AoetR5Bw6wj4niittNyFh6+eOGonYvJ1ao6B8lEa3Q3klS7ADZ53bc5g==",[m
[32m+[m[32m      "dev": true,[m
[32m+[m[32m      "license": "MIT",[m
[32m+[m[32m      "dependencies": {[m
[32m+[m[32m        "@babel/template": "^7.26.9",[m
[32m+[m[32m        "@babel/types": "^7.26.10"[m
[32m+[m[32m      },[m
[32m+[m[32m      "engines": {[m
[32m+[m[32m        "node": ">=6.9.0"[m
[32m+[m[32m      }[m
[32m+[m[32m    },[m
[32m+[m[32m    "node_modules/@babel/parser": {[m
[32m+[m[32m      "version": "7.26.10",[m
[32m+[m[32m      "resolved": "https://registry.npmjs.org/@babel/parser/-/parser-7.26.10.tgz",[m
[32m+[m[32m      "integrity": "sha512-6aQR2zGE/QFi8JpDLjUZEPYOs7+mhKXm86VaKFiLP35JQwQb6bwUE+XbvkH0EptsYhbNBSUGaUBLKqxH1xSgsA==",[m
[32m+[m[32m      "dev": true,[m
[32m+[m[32m      "license": "MIT",[m
[32m+[m[32m      "dependencies": {[m
[32m+[m[32m        "@babel/types": "^7.26.10"[m
[32m+[m[32m      },[m
[32m+[m[32m      "bin": {[m
[32m+[m[32m        "parser": "bin/babel-parser.js"[m
[32m+[m[32m      },[m
[32m+[m[32m      "engines": {[m
[32m+[m[32m        "node": ">=6.0.0"[m
[32m+[m[32m      }[m
[32m+[m[32m    },[m
[32m+[m[32m    "node_modules/@babel/plugin-transform-react-jsx-self": {[m
[32m+[m[32m      "version": "7.25.9",[m
[32m+[m[32m      "resolved": "https://registry.npmjs.org/@babel/plugin-transform-react-jsx-self/-/plugin-transform-react-jsx-self-7.25.9.tgz",[m
[32m+[m[32m      "integrity": "sha512-y8quW6p0WHkEhmErnfe58r7x0A70uKphQm8Sp8cV7tjNQwK56sNVK0M73LK3WuYmsuyrftut4xAkjjgU0twaMg==",[m
[32m+[m[32m      "dev": true,[m
[32m+[m[32m      "license": "MIT",[m
[32m+[m[32m      "dependencies": {[m
[32m+[m[32m        "@babel/helper-plugin-utils": "^7.25.9"[m
[32m+[m[32m      },[m
[32m+[m[32m      "engines": {[m
[32m+[m[32m        "node": ">=6.9.0"[m
[32m+[m[32m      },[m
[32m+[m[32m      "peerDependencies": {[m
[32m+[m[32m        "@babel/core": "^7.0.0-0"[m
[32m+[m[32m      }[m
[32m+[m[32m    },[m
[32m+[m[32m    "node_modules/@babel/plugin-transform-react-jsx-source": {[m
[32m+[m[32m      "version": "7.25.9",[m
[32m+[m[32m      "resolved": "https://registry.npmjs.org/@babel/plugin-transform-react-jsx-source/-/plugin-transform-react-jsx-source-7.25.9.tgz",[m
[32m+[m[32m      "integrity": "sha512-+iqjT8xmXhhYv4/uiYd8FNQsraMFZIfxVSqxxVSZP0WbbSAWvBXAul0m/zu+7Vv4O/3WtApy9pmaTMiumEZgfg==",[m
[32m+[m[32m      "dev": true,[m
[32m+[m[32m      "license": "MIT",[m
[32m+[m[32m      "dependencies": {[m
[32m+[m[32m        "@babel/helper-plugin-utils": "^7.25.9"[m
[32m+[m[32m      },[m
[32m+[m[32m      "engines": {[m
[32m+[m[32m        "node": ">=6.9.0"[m
[32m+[m[32m      },[m
[32m+[m[32m      "peerDependencies": {[m
[32m+[m[32m        "@babel/core": "^7.0.0-0"[m
[32m+[m[32m      }[m
[32m+[m[32m    },[m
[32m+[m[32m    "node_modules/@babel/template": {[m
[32m+[m[32m      "version": "7.26.9",[m
[32m+[m[32m      "resolved": "https://registry.npmjs.org/@babel/template/-/template-7.26.9.tgz",[m
[32m+[m[32m      "integrity": "sha512-qyRplbeIpNZhmzOysF/wFMuP9sctmh2cFzRAZOn1YapxBsE1i9bJIY586R/WBLfLcmcBlM8ROBiQURnnNy+zfA==",[m
[32m+[m[32m      "dev": true,[m
[32m+[m[32m      "license": "MIT",[m
[32m+[m[32m      "dependencies": {[m
[32m+[m[32m        "@babel/code-frame": "^7.26.2",[m
[32m+[m[32m        "@babel/parser": "^7.26.9",[m
[32m+[m[32m        "@babel/types": "^7.26.9"[m
[32m+[m[32m      },[m
[32m+[m[32m      "engines": {[m
[32m+[m[32m        "node": ">=6.9.0"[m
[32m+[m[32m      }[m
[32m+[m[32m    },[m
[32m+[m[32m    "node_modules/@babel/traverse": {[m
[32m+[m[32m      "version": "7.26.10",[m
[32m+[m[32m      "resolved": "https://registry.npmjs.org/@babel/traverse/-/traverse-7.26.10.tgz",[m
[32m+[m[32m      "integrity": "sha512-k8NuDrxr0WrPH5Aupqb2LCVURP/S0vBEn5mK6iH+GIYob66U5EtoZvcdudR2jQ4cmTwhEwW1DLB+Yyas9zjF6A==",[m
[32m+[m[32m      "dev": true,[m
[32m+[m[32m      "license": "MIT",[m
[32m+[m[32m      "dependencies": {[m
[32m+[m[32m        "@babel/code-frame": "^7.26.2",[m
[32m+[m[32m        "@babel/generator": "^7.26.10",[m
[32m+[m[32m        "@babel/parser": "^7.26.10",[m
[32m+[m[32m        "@babel/template": "^7.26.9",[m
[32m+[m[32m        "@babel/types": "^7.26.10",[m
[32m+[m[32m        "debug": "^4.3.1",[m
[32m+[m[32m        "globals": "^11.1.0"[m
[32m+[m[32m      },[m
[32m+[m[32m      "engines": {[m
[32m+[m[32m        "node": ">=6.9.0"[m
[32m+[m[32m      }[m
[32m+[m[32m    },[m
[32m+[m[32m    "node_modules/@babel/traverse/node_modules/globals": {[m
[32m+[m[32m      "version": "11.12.0",[m
[32m+[m[32m      "resolved": "https://registry.npmjs.org/globals/-/globals-11.12.0.tgz",[m
[32m+[m[32m      "integrity": "sha512-WOBp/EEGUiIsJSp7wcv/y6MO+lV9UoncWqxuFfm8eBwzWNgyfBd6Gz+IeKQ9jCmyhoH99g15M3T+QaVHFjizVA==",[m
[32m+[m[32m      "dev": true,[m
[32m+[m[32m      "license": "MIT",[m
[32m+[m[32m      "engines": {[m
[32m+[m[32m        "node": ">=4"[m
[32m+[m[32m      }[m
[32m+[m[32m    },[m
[32m+[m[32m    "node_modules/@babel/types": {[m
[32m+[m[32m      "version": "7.26.10",[m
[32m+[m[32m      "resolved": "https://registry.npmjs.org/@babel/types/-/types-7.26.10.tgz",[m
[32m+[m[32m      "integrity": "sha512-emqcG3vHrpxUKTrxcblR36dcrcoRDvKmnL/dCL6ZsHaShW80qxCAcNhzQZrpeM765VzEos+xOi4s+r4IXzTwdQ==",[m
[32m+[m[32m      "dev": true,[m
[32m+[m[32m      "license": "MIT",[m
[32m+[m[32m      "dependencies": {[m
[32m+[m[32m        "@babel/helper-string-parser": "^7.25.9",[m
[32m+[m[32m        "@babel/helper-validator-identifier": "^7.25.9"[m
[32m+[m[32m      },[m
[32m+[m[32m      "engines": {[m
[32m+[m[32m        "node": ">=6.9.0"[m
[32m+[m[32m      }[m
[32m+[m[32m    },[m
[32m+[m[32m    "node_modules/@esbuild/aix-ppc64": {[m
[32m+[m[32m      "version": "0.25.1",[m
[32m+[m[32m      "resolved": "https://registry.npmjs.org/@esbuild/aix-ppc64/-/aix-ppc64-0.25.1.tgz",[m
[32m+[m[32m      "integrity": "sha512-kfYGy8IdzTGy+z0vFGvExZtxkFlA4zAxgKEahG9KE1ScBjpQnFsNOX8KTU5ojNru5ed5CVoJYXFtoxaq5nFbjQ==",[m
[32m+[m[32m      "cpu": [[m
[32m+[m[32m        "ppc64"[m
[32m+[m[32m      ],[m
[32m+[m[32m      "license": "MIT",[m
[32m+[m[32m      "optional": true,[m
[32m+[m[32m      "os": [[m
[32m+[m[32m        "aix"[m
[32m+[m[32m      ],[m
[32m+[m[32m      "engines": {[m
[32m+[m[32m        "node": ">=18"[m
[32m+[m[32m      }[m
[32m+[m[32m    },[m
[32m+[m[32m    "node_modules/@esbuild/android-arm": {[m
[32m+[m[32m      "version": "0.25.1",[m
[32m+[m[32m      "resolved": "https://registry.npmjs.org/@esbuild/android-arm/-/android-arm-0.25.1.tgz",[m
[32m+[m[32m      "integrity": "sha512-dp+MshLYux6j/JjdqVLnMglQlFu+MuVeNrmT5nk6q07wNhCdSnB7QZj+7G8VMUGh1q+vj2Bq8kRsuyA00I/k+Q==",[m
[32m+[m[32m      "cpu": [[m
[32m+[m[32m        "arm"[m
[32m+[m[32m      ],[m
[32m+[m[32m      "license": "MIT",[m
[32m+[m[32m      "optional": true,[m
[32m+[m[32m      "os": [[m
[32m+[m[32m        "android"[m
[32m+[m[32m      ],[m
[32m+[m[32m      "engines": {[m
[32m+[m[32m        "node": ">=18"[m
[32m+[m[32m      }[m
[32m+[m[32m    },[m
[32m+[m[32m    "node_modules/@esbuild/android-arm64": {[m
[32m+[m[32m      "version": "0.25.1",[m
[32m+[m[32m      "resolved": "https://registry.npmjs.org/@esbuild/android-arm64/-/android-arm64-0.25.1.tgz",[m
[32m+[m[32m      "integrity": "sha512-50tM0zCJW5kGqgG7fQ7IHvQOcAn9TKiVRuQ/lN0xR+T2lzEFvAi1ZcS8DiksFcEpf1t/GYOeOfCAgDHFpkiSmA==",[m
[32m+[m[32m      "cpu": [[m
[32m+[m[32m        "arm64"[m
[32m+[m[32m      ],[m
[32m+[m[32m      "license": "MIT",[m
[32m+[m[32m      "optional": true,[m
[32m+[m[32m      "os": [[m
[32m+[m[32m        "android"[m
[32m+[m[32m      ],[m
[32m+[m[32m      "engines": {[m
[32m+[m[32m        "node": ">=18"[m
[32m+[m[32m      }[m
[32m+[m[32m    },[m
[32m+[m[32m    "node_modules/@esbuild/android-x64": {[m
[32m+[m[32m      "version": "0.25.1",[m
[32m+[m[32m      "resolved": "https://registry.npmjs.org/@esbuild/android-x64/-/android-x64-0.25.1.tgz",[m
[32m+[m[32m      "integrity": "sha512-GCj6WfUtNldqUzYkN/ITtlhwQqGWu9S45vUXs7EIYf+7rCiiqH9bCloatO9VhxsL0Pji+PF4Lz2XXCES+Q8hDw==",[m
[32m+[m[32m      "cpu": [[m
[32m+[m[32m        "x64"[m
[32m+[m[32m      ],[m
[32m+[m[32m      "license": "MIT",[m
[32m+[m[32m      "optional": true,[m
[32m+[m[32m      "os": [[m
[32m+[m[32m        "android"[m
[32m+[m[32m      ],[m
[32m+[m[32m      "engines": {[m
[32m+[m[32m        "node": ">=18"[m
[32m+[m[32m      }[m
[32m+[m[32m    },[m
[32m+[m[32m    "node_modules/@esbuild/darwin-arm64": {[m
[32m+[m[32m      "version": "0.25.1",[m
[32m+[m[32m      "resolved": "https://registry.npmjs.org/@esbuild/darwin-arm64/-/darwin-arm64-0.25.1.tgz",[m
[32m+[m[32m      "integrity": "sha512-5hEZKPf+nQjYoSr/elb62U19/l1mZDdqidGfmFutVUjjUZrOazAtwK+Kr+3y0C/oeJfLlxo9fXb1w7L+P7E4FQ==",[m
[32m+[m[32m      "cpu": [[m
[32m+[m[32m        "arm64"[m
[32m+[m[32m      ],[m
[32m+[m[32m      "license": "MIT",[m
[32m+[m[32m      "optional": true,[m
[32m+[m[32m      "os": [[m
[32m+[m[32m        "darwin"[m
[32m+[m[32m      ],[m
[32m+[m[32m      "engines": {[m
[32m+[m[32m        "node": ">=18"[m
[32m+[m[32m      }[m
[32m+[m[32m    },[m
[32m+[m[32m    "node_modules/@esbuild/darwin-x64": {[m
[32m+[m[32m      "version": "0.25.1",[m
[32m+[m[32m      "resolved": "https://registry.npmjs.org/@esbuild/darwin-x64/-/darwin-x64-0.25.1.tgz",[m
[32m+[m[32m      "integrity": "sha512-hxVnwL2Dqs3fM1IWq8Iezh0cX7ZGdVhbTfnOy5uURtao5OIVCEyj9xIzemDi7sRvKsuSdtCAhMKarxqtlyVyfA==",[m
[32m+[m[32m      "cpu": [[m
[32m+[m[32m        "x64"[m
[32m+[m[32m      ],[m
[32m+[m[32m      "license": "MIT",[m
[32m+[m[32m      "optional": true,[m
[32m+[m[32m      "os": [[m
[32m+[m[32m        "darwin"[m
[32m+[m[32m      ],[m
[32m+[m[32m      "engines": {[m
[32m+[m[32m        "node": ">=18"[m
[32m+[m[32m      }[m
[32m+[m[32m    },[m
[32m+[m[32m    "node_modules/@esbuild/freebsd-arm64": {[m
[32m+[m[32m      "version": "0.25.1",[m
[32m+[m[32m      "resolved": "https://registry.npmjs.org/@esbuild/freebsd-arm64/-/freebsd-arm64-0.25.1.tgz",[m
[32m+[m[32m      "integrity": "sha512-1MrCZs0fZa2g8E+FUo2ipw6jw5qqQiH+tERoS5fAfKnRx6NXH31tXBKI3VpmLijLH6yriMZsxJtaXUyFt/8Y4A==",[m
[32m+[m[32m      "cpu": [[m
[32m+[m[32m        "arm64"[m
[32m+[m[32m      ],[m
[32m+[m[32m      "license": "MIT",[m
[32m+[m[32m      "optional": true,[m
[32m+[m[32m      "os": [[m
[32m+[m[32m        "freebsd"[m
[32m+[m[32m      ],[m
[32m+[m[32m      "engines": {[m
[32m+[m[32m        "node": ">=18"[m
[32m+[m[32m      }[m
[32m+[m[32m    },[m
[32m+[m[32m    "node_modules/@esbuild/freebsd-x64": {[m
[32m+[m[32m      "version": "0.25.1",[m
[32m+[m[32m      "resolved": "https://registry.npmjs.org/@esbuild/freebsd-x64/-/freebsd-x64-0.25.1.tgz",[m
[32m+[m[32m      "integrity": "sha512-0IZWLiTyz7nm0xuIs0q1Y3QWJC52R8aSXxe40VUxm6BB1RNmkODtW6LHvWRrGiICulcX7ZvyH6h5fqdLu4gkww==",[m
[32m+[m[32m      "cpu": [[m
[32m+[m[32m        "x64"[m
[32m+[m[32m      ],[m
[32m+[m[32m      "license": "MIT",[m
[32m+[m[32m      "optional": true,[m
[32m+[m[32m      "os": [[m
[32m+[m[32m        "freebsd"[m
[32m+[m[32m      ],[m
[32m+[m[32m      "engines": {[m
[32m+[m[32m        "node": ">=18"[m
[32m+[m[32m      }[m
[32m+[m[32m    },[m
[32m+[m[32m    "node_modules/@esbuild/linux-arm": {[m
[32m+[m[32m      "version": "0.25.1",[m
[32m+[m[32m      "resolved": "https://registry.npmjs.org/@esbuild/linux-arm/-/linux-arm-0.25.1.tgz",[m
[32m+[m[32m      "integrity": "sha512-NdKOhS4u7JhDKw9G3cY6sWqFcnLITn6SqivVArbzIaf3cemShqfLGHYMx8Xlm/lBit3/5d7kXvriTUGa5YViuQ==",[m
[32m+[m[32m      "cpu": [[m
[32m+[m[32m        "arm"[m
[32m+[m[32m      ],[m
[32m+[m[32m      "license": "MIT",[m
[32m+[m[32m      "optional": true,[m
[32m+[m[32m      "os": [[m
[32m+[m[32m        "linux"[m
[32m+[m[32m      ],[m
[32m+[m[32m      "engines": {[m
[32m+[m[32m        "node": ">=18"[m
[32m+[m[32m      }[m
[32m+[m[32m    },[m
[32m+[m[32m    "node_modules/@esbuild/linux-arm64": {[m
[32m+[m[32m      "version": "0.25.1",[m
[32m+[m[32m      "resolved": "https://registry.npmjs.org/@esbuild/linux-arm64/-/linux-arm64-0.25.1.tgz",[m
[32m+[m[32m      "integrity": "sha512-jaN3dHi0/DDPelk0nLcXRm1q7DNJpjXy7yWaWvbfkPvI+7XNSc/lDOnCLN7gzsyzgu6qSAmgSvP9oXAhP973uQ==",[m
[32m+[m[32m      "cpu": [[m
[32m+[m[32m        "arm64"[m
[32m+[m[32m      ],[m
[32m+[m[32m      "license": "MIT",[m
[32m+[m[32m      "optional": true,[m
[32m+[m[32m      "os": [[m
[32m+[m[32m        "linux"[m
[32m+[m[32m      ],[m
[32m+[m[32m      "engines": {[m
[32m+[m[32m        "node": ">=18"[m
[32m+[m[32m      }[m
[32m+[m[32m    },[m
[32m+[m[32m    "node_modules/@esbuild/linux-ia32": {[m
[32m+[m[32m      "version": "0.25.1",[m
[32m+[m[32m      "resolved": "https://registry.npmjs.org/@esbuild/linux-ia32/-/linux-ia32-0.25.1.tgz",[m
[32m+[m[32m      "integrity": "sha512-OJykPaF4v8JidKNGz8c/q1lBO44sQNUQtq1KktJXdBLn1hPod5rE/Hko5ugKKZd+D2+o1a9MFGUEIUwO2YfgkQ==",[m
[32m+[m[32m      "cpu": [[m
[32m+[m[32m        "ia32"[m
[32m+[m[32m      ],[m
[32m+[m[32m      "license": "MIT",[m
[32m+[m[32m      "optional": true,[m
[32m+[m[32m      "os": [[m
[32m+[m[32m        "linux"[m
[32m+[m[32m      ],[m
[32m+[m[32m      "engines": {[m
[32m+[m[32m        "node": ">=18"[m
[32m+[m[32m      }[m
[32m+[m[32m    },[m
[32m+[m[32m    "node_modules/@esbuild/linux-loong64": {[m
[32m+[m[32m      "version": "0.25.1",[m
[32m+[m[32m      "resolved": "https://registry.npmjs.org/@esbuild/linux-loong64/-/linux-loong64-0.25.1.tgz",[m
[32m+[m[32m      "integrity": "sha512-nGfornQj4dzcq5Vp835oM/o21UMlXzn79KobKlcs3Wz9smwiifknLy4xDCLUU0BWp7b/houtdrgUz7nOGnfIYg==",[m
[32m+[m[32m      "cpu": [[m
[32m+[m[32m        "loong64"[m
[32m+[m[32m      ],[m
[32m+[m[32m      "license": "MIT",[m
[32m+[m[32m      "optional": true,[m
[32m+[m[32m      "os": [[m
[32m+[m[32m        "linux"[m
[32m+[m[32m      ],[m
[32m+[m[32m      "engines": {[m
[32m+[m[32m        "node": ">=18"[m
[32m+[m[32m      }[m
[32m+[m[32m    },[m
[32m+[m[32m    "node_modules/@esbuild/linux-mips64el": {[m
[32m+[m[32m      "version": "0.25.1",[m
[32m+[m[32m      "resolved": "https://registry.npmjs.org/@esbuild/linux-mips64el/-/linux-mips64el-0.25.1.tgz",[m
[32m+[m[32m      "integrity": "sha512-1osBbPEFYwIE5IVB/0g2X6i1qInZa1aIoj1TdL4AaAb55xIIgbg8Doq6a5BzYWgr+tEcDzYH67XVnTmUzL+nXg==",[m
[32m+[m[32m      "cpu": [[m
[32m+[m[32m        "mips64el"[m
[32m+[m[32m      ],[m
[32m+[m[32m      "license": "MIT",[m
[32m+[m[32m      "optional": true,[m
[32m+[m[32m      "os": [[m
[32m+[m[32m        "linux"[m
[32m+[m[32m      ],[m
[32m+[m[32m      "engines": {[m
[32m+[m[32m        "node": ">=18"[m
[32m+[m[32m      }[m
[32m+[m[32m    },[m
[32m+[m[32m    "node_modules/@esbuild/linux-ppc64": {[m
[32m+[m[32m      "version": "0.25.1",[m
[32m+[m[32m      "resolved": "https://registry.npmjs.org/@esbuild/linux-ppc64/-/linux-ppc64-0.25.1.tgz",[m
[32m+[m[32m      "integrity": "sha512-/6VBJOwUf3TdTvJZ82qF3tbLuWsscd7/1w+D9LH0W/SqUgM5/JJD0lrJ1fVIfZsqB6RFmLCe0Xz3fmZc3WtyVg==",[m
[32m+[m[32m      "cpu": [[m
[32m+[m[32m        "ppc64"[m
[32m+[m[32m      ],[m
[32m+[m[32m      "license": "MIT",[m
[32m+[m[32m      "optional": true,[m
[32m+[m[32m      "os": [[m
[32m+[m[32m        "linux"[m
[32m+[m[32m      ],[m
[32m+[m[32m      "engines": {[m
[32m+[m[32m        "node": ">=18"[m
[32m+[m[32m      }[m
[32m+[m[32m    },[m
[32m+[m[32m    "node_modules/@esbuild/linux-riscv64": {[m
[32m+[m[32m      "version": "0.25.1",[m
[32m+[m[32m      "resolved": "https://registry.npmjs.org/@esbuild/linux-riscv64/-/linux-riscv64-0.25.1.tgz",[m
[32m+[m[32m      "integrity": "sha512-nSut/Mx5gnilhcq2yIMLMe3Wl4FK5wx/o0QuuCLMtmJn+WeWYoEGDN1ipcN72g1WHsnIbxGXd4i/MF0gTcuAjQ==",[m
[32m+[m[32m      "cpu": [[m
[32m+[m[32m        "riscv64"[m
[32m+[m[32m      ],[m
[32m+[m[32m      "license": "MIT",[m
[32m+[m[32m      "optional": true,[m
[32m+[m[32m      "os": [[m
[32m+[m[32m        "linux"[m
[32m+[m[32m      ],[m
[32m+[m[32m      "engines": {[m
[32m+[m[32m        "node": ">=18"[m
[32m+[m[32m      }[m
[32m+[m[32m    },[m
[32m+[m[32m    "node_modules/@esbuild/linux-s390x": {[m
[32m+[m[32m      "version": "0.25.1",[m
[32m+[m[32m      "resolved": "https://registry.npmjs.org/@esbuild/linux-s390x/-/linux-s390x-0.25.1.tgz",[m
[32m+[m[32m      "integrity": "sha512-cEECeLlJNfT8kZHqLarDBQso9a27o2Zd2AQ8USAEoGtejOrCYHNtKP8XQhMDJMtthdF4GBmjR2au3x1udADQQQ==",[m
[32m+[m[32m      "cpu": [[m
[32m+[m[32m        "s390x"[m
[32m+[m[32m      ],[m
[32m+[m[32m      "license": "MIT",[m
[32m+[m[32m      "optional": true,[m
[32m+[m[32m      "os": [[m
[32m+[m[32m        "linux"[m
[32m+[m[32m      ],[m
[32m+[m[32m      "engines": {[m
[32m+[m[32m        "node": ">=18"[m
[32m+[m[32m      }[m
[32m+[m[32m    },[m
[32m+[m[32m    "node_modules/@esbuild/linux-x64": {[m
[32m+[m[32m      "version": "0.25.1",[m
[32m+[m[32m      "resolved": "https://registry.npmjs.org/@esbuild/linux-x64/-/linux-x64-0.25.1.tgz",[m
[32m+[m[32m      "integrity": "sha512-xbfUhu/gnvSEg+EGovRc+kjBAkrvtk38RlerAzQxvMzlB4fXpCFCeUAYzJvrnhFtdeyVCDANSjJvOvGYoeKzFA==",[m
[32m+[m[32m      "cpu": [[m
[32m+[m[32m        "x64"[m
[32m+[m[32m      ],[m
[32m+[m[32m      "license": "MIT",[m
[32m+[m[32m      "optional": true,[m
[32m+[m[32m      "os": [[m
[32m+[m[32m        "linux"[m
[32m+[m[32m      ],[m
[32m+[m[32m      "engines": {[m
[32m+[m[32m        "node": ">=18"[m
[32m+[m[32m      }[m
[32m+[m[32m    },[m
[32m+[m[32m    "node_modules/@esbuild/netbsd-arm64": {[m
[32m+[m[32m      "version": "0.25.1",[m
[32m+[m[32m      "resolved": "https://registry.npmjs.org/@esbuild/netbsd-arm64/-/netbsd-arm64-0.25.1.tgz",[m
[32m+[m[32m      "integrity": "sha512-O96poM2XGhLtpTh+s4+nP7YCCAfb4tJNRVZHfIE7dgmax+yMP2WgMd2OecBuaATHKTHsLWHQeuaxMRnCsH8+5g==",[m
[32m+[m[32m      "cpu": [[m
[32m+[m[32m        "arm64"[m
[32m+[m[32m      ],[m
[32m+[m[32m      "license": "MIT",[m
[32m+[m[32m      "optional": true,[m
[32m+[m[32m      "os": [[m
[32m+[m[32m        "netbsd"[m
[32m+[m[32m      ],[m
[32m+[m[32m      "engines": {[m
[32m+[m[32m        "node": ">=18"[m
[32m+[m[32m      }[m
[32m+[m[32m    },[m
[32m+[m[32m    "node_modules/@esbuild/netbsd-x64": {[m
[32m+[m[32m      "version": "0.25.1",[m
[32m+[m[32m      "resolved": "https://registry.npmjs.org/@esbuild/netbsd-x64/-/netbsd-x64-0.25.1.tgz",[m
[32m+[m[32m      "integrity": "sha512-X53z6uXip6KFXBQ+Krbx25XHV/NCbzryM6ehOAeAil7X7oa4XIq+394PWGnwaSQ2WRA0KI6PUO6hTO5zeF5ijA==",[m
[32m+[m[32m      "cpu": [[m
[32m+[m[32m        "x64"[m
[32m+[m[32m      ],[m
[32m+[m[32m      "license": "MIT",[m
[32m+[m[32m      "optional": true,[m
[32m+[m[32m      "os": [[m
[32m+[m[32m        "netbsd"[m
[32m+[m[32m      ],[m
[32m+[m[32m      "engines": {[m
[32m+[m[32m        "node": ">=18"[m
[32m+[m[32m      }[m
[32m+[m[32m    },[m
[32m+[m[32m    "node_modules/@esbuild/openbsd-arm64": {[m
[32m+[m[32m      "version": "0.25.1",[m
[32m+[m[32m      "resolved": "https://registry.npmjs.org/@esbuild/openbsd-arm64/-/openbsd-arm64-0.25.1.tgz",[m
[32m+[m[32m      "integrity": "sha512-Na9T3szbXezdzM/Kfs3GcRQNjHzM6GzFBeU1/6IV/npKP5ORtp9zbQjvkDJ47s6BCgaAZnnnu/cY1x342+MvZg==",[m
[32m+[m[32m      "cpu": [[m
[32m+[m[32m        "arm64"[m
[32m+[m[32m      ],[m
[32m+[m[32m      "license": "MIT",[m
[32m+[m[32m      "optional": true,[m
[32m+[m[32m      "os": [[m
[32m+[m[32m        "openbsd"[m
[32m+[m[32m      ],[m
[32m+[m[32m      "engines": {[m
[32m+[m[32m        "node": ">=18"[m
[32m+[m[32m      }[m
[32m+[m[32m    },[m
[32m+[m[32m    "node_modules/@esbuild/openbsd-x64": {[m
[32m+[m[32m      "version": "0.25.1",[m
[32m+[m[32m      "resolved": "https://registry.npmjs.org/@esbuild/openbsd-x64/-/openbsd-x64-0.25.1.tgz",[m
[32m+[m[32m      "integrity": "sha512-T3H78X2h1tszfRSf+txbt5aOp/e7TAz3ptVKu9Oyir3IAOFPGV6O9c2naym5TOriy1l0nNf6a4X5UXRZSGX/dw==",[m
[32m+[m[32m      "cpu": [[m
[32m+[m[32m        "x64"[m
[32m+[m[32m      ],[m
[32m+[m[32m      "license": "MIT",[m
[32m+[m[32m      "optional": true,[m
[32m+[m[32m      "os": [[m
[32m+[m[32m        "openbsd"[m
[32m+[m[32m      ],[m
[32m+[m[32m      "engines": {[m
[32m+[m[32m        "node": ">=18"[m
[32m+[m[32m      }[m
[32m+[m[32m    },[m
[32m+[m[32m    "node_modules/@esbuild/sunos-x64": {[m
[32m+[m[32m      "version": "0.25.1",[m
[32m+[m[32m      "resolved": "https://registry.npmjs.org/@esbuild/sunos-x64/-/sunos-x64-0.25.1.tgz",[m
[32m+[m[32m      "integrity": "sha512-2H3RUvcmULO7dIE5EWJH8eubZAI4xw54H1ilJnRNZdeo8dTADEZ21w6J22XBkXqGJbe0+wnNJtw3UXRoLJnFEg==",[m
[32m+[m[32m      "cpu": [[m
[32m+[m[32m        "x64"[m
[32m+[m[32m      ],[m
[32m+[m[32m      "license": "MIT",[m
[32m+[m[32m      "optional": true,[m
[32m+[m[32m      "os": [[m
[32m+[m[32m        "sunos"[m
[32m+[m[32m      ],[m
[32m+[m[32m      "engines": {[m
[32m+[m[32m        "node": ">=18"[m
[32m+[m[32m      }[m
[32m+[m[32m    },[m
[32m+[m[32m    "node_modules/@esbuild/win32-arm64": {[m
[32m+[m[32m      "version": "0.25.1",[m
[32m+[m[32m      "resolved": "https://registry.npmjs.org/@esbuild/win32-arm64/-/win32-arm64-0.25.1.tgz",[m
[32m+[m[32m      "integrity": "sha512-GE7XvrdOzrb+yVKB9KsRMq+7a2U/K5Cf/8grVFRAGJmfADr/e/ODQ134RK2/eeHqYV5eQRFxb1hY7Nr15fv1NQ==",[m
[32m+[m[32m      "cpu": [[m
[32m+[m[32m        "arm64"[m
[32m+[m[32m      ],[m
[32m+[m[32m      "license": "MIT",[m
[32m+[m[32m      "optional": true,[m
[32m+[m[32m      "os": [[m
[32m+[m[32m        "win32"[m
[32m+[m[32m      ],[m
[32m+[m[32m      "engines": {[m
[32m+[m[32m        "node": ">=18"[m
[32m+[m[32m      }[m
[32m+[m[32m    },[m
[32m+[m[32m    "node_modules/@esbuild/win32-ia32": {[m
[32m+[m[32m      "version": "0.25.1",[m
[32m+[m[32m      "resolved": "https://registry.npmjs.org/@esbuild/win32-ia32/-/win32-ia32-0.25.1.tgz",[m
[32m+[m[32m      "integrity": "sha512-uOxSJCIcavSiT6UnBhBzE8wy3n0hOkJsBOzy7HDAuTDE++1DJMRRVCPGisULScHL+a/ZwdXPpXD3IyFKjA7K8A==",[m
[32m+[m[32m      "cpu": [[m
[32m+[m[32m        "ia32"[m
[32m+[m[32m      ],[m
[32m+[m[32m      "license": "MIT",[m
[32m+[m[32m      "optional": true,[m
[32m+[m[32m      "os": [[m
[32m+[m[32m        "win32"[m
[32m+[m[32m      ],[m
[32m+[m[32m      "engines": {[m
[32m+[m[32m        "node": ">=18"[m
[32m+[m[32m      }[m
[32m+[m[32m    },[m
[32m+[m[32m    "node_modules/@esbuild/win32-x64": {[m
[32m+[m[32m      "version": "0.25.1",[m
[32m+[m[32m      "resolved": "https://registry.npmjs.org/@esbuild/win32-x64/-/win32-x64-0.25.1.tgz",[m
[32m+[m[32m      "integrity": "sha512-Y1EQdcfwMSeQN/ujR5VayLOJ1BHaK+ssyk0AEzPjC+t1lITgsnccPqFjb6V+LsTp/9Iov4ysfjxLaGJ9RPtkVg==",[m
[32m+[m[32m      "cpu": [[m
[32m+[m[32m        "x64"[m
[32m+[m[32m      ],[m
[32m+[m[32m      "license": "MIT",[m
[32m+[m[32m      "optional": true,[m
[32m+[m[32m      "os": [[m
[32m+[m[32m        "win32"[m
[32m+[m[32m      ],[m
[32m+[m[32m      "engines": {[m
[32m+[m[32m        "node": ">=18"[m
[32m+[m[32m      }[m
[32m+[m[32m    },[m
[32m+[m[32m    "node_modules/@eslint-community/eslint-utils": {[m
[32m+[m[32m      "version": "4.5.1",[m
[32m+[m[32m      "resolved": "https://registry.npmjs.org/@eslint-community/eslint-utils/-/eslint-utils-4.5.1.tgz",[m
[32m+[m[32m      "integrity": "sha512-soEIOALTfTK6EjmKMMoLugwaP0rzkad90iIWd1hMO9ARkSAyjfMfkRRhLvD5qH7vvM0Cg72pieUfR6yh6XxC4w==",[m
[32m+[m[32m      "dev": true,[m
[32m+[m[32m      "license": "MIT",[m
[32m+[m[32m      "dependencies": {[m
[32m+[m[32m        "eslint-visitor-keys": "^3.4.3"[m
[32m+[m[32m      },[m
[32m+[m[32m      "engines": {[m
[32m+[m[32m        "node": "^12.22.0 || ^14.17.0 || >=16.0.0"[m
[32m+[m[32m      },[m
[32m+[m[32m      "funding": {[m
[32m+[m[32m        "url": "https://opencollective.com/eslint"[m
[32m+[m[32m      },[m
[32m+[m[32m      "peerDependencies": {[m
[32m+[m[32m        "eslint": "^6.0.0 || ^7.0.0 || >=8.0.0"[m
[32m+[m[32m      }[m
[32m+[m[32m    },[m
[32m+[m[32m    "node_modules/@eslint-community/eslint-utils/node_modules/eslint-visitor-keys": {[m
[32m+[m[32m      "version": "3.4.3",[m
[32m+[m[32m      "resolved": "https://registry.npmjs.org/eslint-visitor-keys/-/eslint-visitor-keys-3.4.3.tgz",[m
[32m+[m[32m      "integrity": "sha512-wpc+LXeiyiisxPlEkUzU6svyS1frIO3Mgxj1fdy7Pm8Ygzguax2N3Fa/D/ag1WqbOprdI+uY6wMUl8/a2G+iag==",[m
[32m+[m[32m      "dev": true,[m
[32m+[m[32m      "license": "Apache-2.0",[m
[32m+[m[32m      "engines": {[m
[32m+[m[32m        "node": "^12.22.0 || ^14.17.0 || >=16.0.0"[m
[32m+[m[32m      },[m
[32m+[m[32m      "funding": {[m
[32m+[m[32m        "url": "https://opencollective.com/eslint"[m
[32m+[m[32m      }[m
[32m+[m[32m    },[m
[32m+[m[32m    "node_modules/@eslint-community/regexpp": {[m
[32m+[m[32m      "version": "4.12.1",[m
[32m+[m[32m      "resolved": "https://registry.npmjs.org/@eslint-community/regexpp/-/regexpp-4.12.1.tgz",[m
[32m+[m[32m      "integrity": "sha512-CCZCDJuduB9OUkFkY2IgppNZMi2lBQgD2qzwXkEia16cge2pijY/aXi96CJMquDMn3nJdlPV1A5KrJEXwfLNzQ==",[m
[32m+[m[32m      "dev": true,[m
[32m+[m[32m      "license": "MIT",[m
[32m+[m[32m      "engines": {[m
[32m+[m[32m        "node": "^12.0.0 || ^14.0.0 || >=16.0.0"[m
[32m+[m[32m      }[m
[32m+[m[32m    },[m
[32m+[m[32m    "node_modules/@eslint/config-array": {[m
[32m+[m[32m      "version": "0.19.2",[m
[32m+[m[32m      "resolved": "https://registry.npmjs.org/@eslint/config-array/-/config-array-0.19.2.tgz",[m
[32m+[m[32m      "integrity": "sha512-GNKqxfHG2ySmJOBSHg7LxeUx4xpuCoFjacmlCoYWEbaPXLwvfIjixRI12xCQZeULksQb23uiA8F40w5TojpV7w==",[m
[32m+[m[32m      "dev": true,[m
[32m+[m[32m      "license": "Apache-2.0",[m
[32m+[m[32m      "dependencies": {[m
[32m+[m[32m        "@eslint/object-schema": "^2.1.6",[m
[32m+[m[32m        "debug": "^4.3.1",[m
[32m+[m[32m        "minimatch": "^3.1.2"[m
[32m+[m[32m      },[m
[32m+[m[32m      "engines": {[m
[32m+[m[32m        "node": "^18.18.0 || ^20.9.0 || >=21.1.0"[m
[32m+[m[32m      }[m
[32m+[m[32m    },[m
[32m+[m[32m    "node_modules/@eslint/config-helpers": {[m
[32m+[m[32m      "version": "0.2.0",[m
[32m+[m[32m      "resolved": "https://registry.npmjs.org/@eslint/config-helpers/-/config-helpers-0.2.0.tgz",[m
[32m+[m[32m      "integrity": "sha512-yJLLmLexii32mGrhW29qvU3QBVTu0GUmEf/J4XsBtVhp4JkIUFN/BjWqTF63yRvGApIDpZm5fa97LtYtINmfeQ==",[m
[32m+[m[32m      "dev": true,[m
[32m+[m[32m      "license": "Apache-2.0",[m
[32m+[m[32m      "engines": {[m
[32m+[m[32m        "node": "^18.18.0 || ^20.9.0 || >=21.1.0"[m
[32m+[m[32m      }[m
[32m+[m[32m    },[m
[32m+[m[32m    "node_modules/@eslint/core": {[m
[32m+[m[32m      "version": "0.12.0",[m
[32m+[m[32m      "resolved": "https://registry.npmjs.org/@eslint/core/-/core-0.12.0.tgz",[m
[32m+[m[32m      "integrity": "sha512-cmrR6pytBuSMTaBweKoGMwu3EiHiEC+DoyupPmlZ0HxBJBtIxwe+j/E4XPIKNx+Q74c8lXKPwYawBf5glsTkHg==",[m
[32m+[m[32m      "dev": true,[m
[32m+[m[32m      "license": "Apache-2.0",[m
[32m+[m[32m      "dependencies": {[m
[32m+[m[32m        "@types/json-schema": "^7.0.15"[m
[32m+[m[32m      },[m
[32m+[m[32m      "engines": {[m
[32m+[m[32m        "node": "^18.18.0 || ^20.9.0 || >=21.1.0"[m
[32m+[m[32m      }[m
[32m+[m[32m    },[m
[32m+[m[32m    "node_modules/@eslint/eslintrc": {[m
[32m+[m[32m      "version": "3.3.1",[m
[32m+[m[32m      "resolved": "https://registry.npmjs.org/@eslint/eslintrc/-/eslintrc-3.3.1.tgz",[m
[32m+[m[32m      "integrity": "sha512-gtF186CXhIl1p4pJNGZw8Yc6RlshoePRvE0X91oPGb3vZ8pM3qOS9W9NGPat9LziaBV7XrJWGylNQXkGcnM3IQ==",[m
[32m+[m[32m      "dev": true,[m
[32m+[m[32m      "license": "MIT",[m
[32m+[m[32m      "dependencies": {[m
[32m+[m[32m        "ajv": "^6.12.4",[m
[32m+[m[32m        "debug": "^4.3.2",[m
[32m+[m[32m        "espree": "^10.0.1",[m
[32m+[m[32m        "globals": "^14.0.0",[m
[32m+[m[32m        "ignore": "^5.2.0",[m
[32m+[m[32m        "import-fresh": "^3.2.1",[m
[32m+[m[32m        "js-yaml": "^4.1.0",[m
[32m+[m[32m        "minimatch": "^3.1.2",[m
[32m+[m[32m        "strip-json-comments": "^3.1.1"[m
[32m+[m[32m      },[m
[32m+[m[32m      "engines": {[m
[32m+[m[32m        "node": "^18.18.0 || ^20.9.0 || >=21.1.0"[m
[32m+[m[32m      },[m
[32m+[m[32m      "funding": {[m
[32m+[m[32m        "url": "https://opencollective.com/eslint"[m
[32m+[m[32m      }[m
[32m+[m[32m    },[m
[32m+[m[32m    "node_modules/@eslint/eslintrc/node_modules/globals": {[m
[32m+[m[32m      "version": "14.0.0",[m
[32m+[m[32m      "resolved": "https://registry.npmjs.org/globals/-/globals-14.0.0.tgz",[m
[32m+[m[32m      "integrity": "sha512-oahGvuMGQlPw/ivIYBjVSrWAfWLBeku5tpPE2fOPLi+WHffIWbuh2tCjhyQhTBPMf5E9jDEH4FOmTYgYwbKwtQ==",[m
[32m+[m[32m      "dev": true,[m
[32m+[m[32m      "license": "MIT",[m
[32m+[m[32m      "engines": {[m
[32m+[m[32m        "node": ">=18"[m
[32m+[m[32m      },[m
[32m+[m[32m      "funding": {[m
[32m+[m[32m        "url": "https://github.com/sponsors/sindresorhus"[m
[32m+[m[32m      }[m
[32m+[m[32m    },[m
[32m+[m[32m    "node_modules/@eslint/js": {[m
[32m+[m[32m      "version": "9.23.0",[m
[32m+[m[32m      "resolved": "https://registry.npmjs.org/@eslint/js/-/js-9.23.0.tgz",[m
[32m+[m[32m      "integrity": "sha512-35MJ8vCPU0ZMxo7zfev2pypqTwWTofFZO6m4KAtdoFhRpLJUpHTZZ+KB3C7Hb1d7bULYwO4lJXGCi5Se+8OMbw==",[m
[32m+[m[32m      "dev": true,[m
[32m+[m[32m      "license": "MIT",[m
[32m+[m[32m      "engines": {[m
[32m+[m[32m        "node": "^18.18.0 || ^20.9.0 || >=21.1.0"[m
[32m+[m[32m      }[m
[32m+[m[32m    },[m
[32m+[m[32m    "node_modules/@eslint/object-schema": {[m
[32m+[m[32m      "version": "2.1.6",[m
[32m+[m[32m      "resolved": "https://registry.npmjs.org/@eslint/object-schema/-/object-schema-2.1.6.tgz",[m
[32m+[m[32m      "integrity": "sha512-RBMg5FRL0I0gs51M/guSAj5/e14VQ4tpZnQNWwuDT66P14I43ItmPfIZRhO9fUVIPOAQXU47atlywZ/czoqFPA==",[m
[32m+[m[32m      "dev": true,[m
[32m+[m[32m      "license": "Apache-2.0",[m
[32m+[m[32m      "engines": {[m
[32m+[m[32m        "node": "^18.18.0 || ^20.9.0 || >=21.1.0"[m
[32m+[m[32m      }[m
[32m+[m[32m    },[m
[32m+[m[32m    "node_modules/@eslint/plugin-kit": {[m
[32m+[m[32m      "version": "0.2.7",[m
[32m+[m[32m      "resolved": "https://registry.npmjs.org/@eslint/plugin-kit/-/plugin-kit-0.2.7.tgz",[m
[32m+[m[32m      "integrity": "sha512-JubJ5B2pJ4k4yGxaNLdbjrnk9d/iDz6/q8wOilpIowd6PJPgaxCuHBnBszq7Ce2TyMrywm5r4PnKm6V3iiZF+g==",[m
[32m+[m[32m      "dev": true,[m
[32m+[m[32m      "license": "Apache-2.0",[m
[32m+[m[32m      "dependencies": {[m
[32m+[m[32m        "@eslint/core": "^0.12.0",[m
[32m+[m[32m        "levn": "^0.4.1"[m
[32m+[m[32m      },[m
[32m+[m[32m      "engines": {[m
[32m+[m[32m        "node": "^18.18.0 || ^20.9.0 || >=21.1.0"[m
[32m+[m[32m      }[m
[32m+[m[32m    },[m
[32m+[m[32m    "node_modules/@humanfs/core": {[m
[32m+[m[32m      "version": "0.19.1",[m
[32m+[m[32m      "resolved": "https://registry.npmjs.org/@humanfs/core/-/core-0.19.1.tgz",[m
[32m+[m[32m      "integrity": "sha512-5DyQ4+1JEUzejeK1JGICcideyfUbGixgS9jNgex5nqkW+cY7WZhxBigmieN5Qnw9ZosSNVC9KQKyb+GUaGyKUA==",[m
[32m+[m[32m      "dev": true,[m
[32m+[m[32m      "license": "Apache-2.0",[m
[32m+[m[32m      "engines": {[m
[32m+[m[32m        "node": ">=18.18.0"[m
[32m+[m[32m      }[m
[32m+[m[32m    },[m
[32m+[m[32m    "node_modules/@humanfs/node": {[m
[32m+[m[32m      "version": "0.16.6",[m
[32m+[m[32m      "resolved": "https://registry.npmjs.org/@humanfs/node/-/node-0.16.6.tgz",[m
[32m+[m[32m      "integrity": "sha512-YuI2ZHQL78Q5HbhDiBA1X4LmYdXCKCMQIfw0pw7piHJwyREFebJUvrQN4cMssyES6x+vfUbx1CIpaQUKYdQZOw==",[m
[32m+[m[32m      "dev": true,[m
[32m+[m[32m      "license": "Apache-2.0",[m
[32m+[m[32m      "dependencies": {[m
[32m+[m[32m        "@humanfs/core": "^0.19.1",[m
[32m+[m[32m        "@humanwhocodes/retry": "^0.3.0"[m
[32m+[m[32m      },[m
[32m+[m[32m      "engines": {[m
[32m+[m[32m        "node": ">=18.18.0"[m
[32m+[m[32m      }[m
[32m+[m[32m    },[m
[32m+[m[32m    "node_modules/@humanfs/node/node_modules/@humanwhocodes/retry": {[m
[32m+[m[32m      "version": "0.3.1",[m
[32m+[m[32m      "resolved": "https://registry.npmjs.org/@humanwhocodes/retry/-/retry-0.3.1.tgz",[m
[32m+[m[32m      "integrity": "sha512-JBxkERygn7Bv/GbN5Rv8Ul6LVknS+5Bp6RgDC/O8gEBU/yeH5Ui5C/OlWrTb6qct7LjjfT6Re2NxB0ln0yYybA==",[m
[32m+[m[32m      "dev": true,[m
[32m+[m[32m      "license": "Apache-2.0",[m
[32m+[m[32m      "engines": {[m
[32m+[m[32m        "node": ">=18.18"[m
[32m+[m[32m      },[m
[32m+[m[32m      "funding": {[m
[32m+[m[32m        "type": "github",[m
[32m+[m[32m        "url": "https://github.com/sponsors/nzakas"[m
[32m+[m[32m      }[m
[32m+[m[32m    },[m
[32m+[m[32m    "node_modules/@humanwhocodes/module-importer": {[m
[32m+[m[32m      "version": "1.0.1",[m
[32m+[m[32m      "resolved": "https://registry.npmjs.org/@humanwhocodes/module-importer/-/module-importer-1.0.1.tgz",[m
[32m+[m[32m      "integrity": "sha512-bxveV4V8v5Yb4ncFTT3rPSgZBOpCkjfK0y4oVVVJwIuDVBRMDXrPyXRL988i5ap9m9bnyEEjWfm5WkBmtffLfA==",[m
[32m+[m[32m      "dev": true,[m
[32m+[m[32m      "license": "Apache-2.0",[m
[32m+[m[32m      "engines": {[m
[32m+[m[32m        "node": ">=12.22"[m
[32m+[m[32m      },[m
[32m+[m[32m      "funding": {[m
[32m+[m[32m        "type": "github",[m
[32m+[m[32m        "url": "https://github.com/sponsors/nzakas"[m
[32m+[m[32m      }[m
[32m+[m[32m    },[m
[32m+[m[32m    "node_modules/@humanwhocodes/retry": {[m
[32m+[m[32m      "version": "0.4.2",[m
[32m+[m[32m      "resolved": "https://registry.npmjs.org/@humanwhocodes/retry/-/retry-0.4.2.tgz",[m
[32m+[m[32m      "integrity": "sha512-xeO57FpIu4p1Ri3Jq/EXq4ClRm86dVF2z/+kvFnyqVYRavTZmaFaUBbWCOuuTh0o/g7DSsk6kc2vrS4Vl5oPOQ==",[m
[32m+[m[32m      "dev": true,[m
[32m+[m[32m      "license": "Apache-2.0",[m
[32m+[m[32m      "engines": {[m
[32m+[m[32m        "node": ">=18.18"[m
[32m+[m[32m      },[m
[32m+[m[32m      "funding": {[m
[32m+[m[32m        "type": "github",[m
[32m+[m[32m        "url": "https://github.com/sponsors/nzakas"[m
[32m+[m[32m      }[m
[32m+[m[32m    },[m
[32m+[m[32m    "node_modules/@jridgewell/gen-mapping": {[m
[32m+[m[32m      "version": "0.3.8",[m
[32m+[m[32m      "resolved": "https://registry.npmjs.org/@jridgewell/gen-mapping/-/gen-mapping-0.3.8.tgz",[m
[32m+[m[32m      "integrity": "sha512-imAbBGkb+ebQyxKgzv5Hu2nmROxoDOXHh80evxdoXNOrvAnVx7zimzc1Oo5h9RlfV4vPXaE2iM5pOFbvOCClWA==",[m
[32m+[m[32m      "dev": true,[m
[32m+[m[32m      "license": "MIT",[m
[32m+[m[32m      "dependencies": {[m
[32m+[m[32m        "@jridgewell/set-array": "^1.2.1",[m
[32m+[m[32m        "@jridgewell/sourcemap-codec": "^1.4.10",[m
[32m+[m[32m        "@jridgewell/trace-mapping": "^0.3.24"[m
[32m+[m[32m      },[m
[32m+[m[32m      "engines": {[m
[32m+[m[32m        "node": ">=6.0.0"[m
[32m+[m[32m      }[m
[32m+[m[32m    },[m
[32m+[m[32m    "node_modules/@jridgewell/resolve-uri": {[m
[32m+[m[32m      "version": "3.1.2",[m
[32m+[m[32m      "resolved": "https://registry.npmjs.org/@jridgewell/resolve-uri/-/resolve-uri-3.1.2.tgz",[m
[32m+[m[32m      "integrity": "sha512-bRISgCIjP20/tbWSPWMEi54QVPRZExkuD9lJL+UIxUKtwVJA8wW1Trb1jMs1RFXo1CBTNZ/5hpC9QvmKWdopKw==",[m
[32m+[m[32m      "dev": true,[m
[32m+[m[32m      "license": "MIT",[m
[32m+[m[32m      "engines": {[m
[32m+[m[32m        "node": ">=6.0.0"[m
[32m+[m[32m      }[m
[32m+[m[32m    },[m
[32m+[m[32m    "node_modules/@jridgewell/set-array": {[m
[32m+[m[32m      "version": "1.2.1",[m
[32m+[m[32m      "resolved": "https://registry.npmjs.org/@jridgewell/set-array/-/set-array-1.2.1.tgz",[m
[32m+[m[32m      "integrity": "sha512-R8gLRTZeyp03ymzP/6Lil/28tGeGEzhx1q2k703KGWRAI1VdvPIXdG70VJc2pAMw3NA6JKL5hhFu1sJX0Mnn/A==",[m
[32m+[m[32m      "dev": true,[m
[32m+[m[32m      "license": "MIT",[m
[32m+[m[32m      "engines": {[m
[32m+[m[32m        "node": ">=6.0.0"[m
[32m+[m[32m      }[m
[32m+[m[32m    },[m
[32m+[m[32m    "node_modules/@jridgewell/sourcemap-codec": {[m
[32m+[m[32m      "version": "1.5.0",[m
[32m+[m[32m      "resolved": "https://registry.npmjs.org/@jridgewell/sourcemap-codec/-/sourcemap-codec-1.5.0.tgz",[m
[32m+[m[32m      "integrity": "sha512-gv3ZRaISU3fjPAgNsriBRqGWQL6quFx04YMPW/zD8XMLsU32mhCCbfbO6KZFLjvYpCZ8zyDEgqsgf+PwPaM7GQ==",[m
[32m+[m[32m      "dev": true,[m
[32m+[m[32m      "license": "MIT"[m
[32m+[m[32m    },[m
[32m+[m[32m    "node_modules/@jridgewell/trace-mapping": {[m
[32m+[m[32m      "version": "0.3.25",[m
[32m+[m[32m      "resolved": "https://registry.npmjs.org/@jridgewell/trace-mapping/-/trace-mapping-0.3.25.tgz",[m
[32m+[m[32m      "integrity": "sha512-vNk6aEwybGtawWmy/PzwnGDOjCkLWSD2wqvjGGAgOAwCGWySYXfYoxt00IJkTF+8Lb57DwOb3Aa0o9CApepiYQ==",[m
[32m+[m[32m      "dev": true,[m
[32m+[m[32m      "license": "MIT",[m
[32m+[m[32m      "dependencies": {[m
[32m+[m[32m        "@jridgewell/resolve-uri": "^3.1.0",[m
[32m+[m[32m        "@jridgewell/sourcemap-codec": "^1.4.14"[m
[32m+[m[32m      }[m
[32m+[m[32m    },[m
[32m+[m[32m    "node_modules/@rollup/rollup-android-arm-eabi": {[m
[32m+[m[32m      "version": "4.37.0",[m
[32m+[m[32m      "resolved": "https://registry.npmjs.org/@rollup/rollup-android-arm-eabi/-/rollup-android-arm-eabi-4.37.0.tgz",[m
[32m+[m[32m      "integrity": "sha512-l7StVw6WAa8l3vA1ov80jyetOAEo1FtHvZDbzXDO/02Sq/QVvqlHkYoFwDJPIMj0GKiistsBudfx5tGFnwYWDQ==",[m
[32m+[m[32m      "cpu": [[m
[32m+[m[32m        "arm"[m
[32m+[m[32m      ],[m
[32m+[m[32m      "license": "MIT",[m
[32m+[m[32m      "optional": true,[m
[32m+[m[32m      "os": [[m
[32m+[m[32m        "android"[m
[32m+[m[32m      ][m
[32m+[m[32m    },[m
[32m+[m[32m    "node_modules/@rollup/rollup-android-arm64": {[m
[32m+[m[32m      "version": "4.37.0",[m
[32m+[m[32m      "resolved": "https://registry.npmjs.org/@rollup/rollup-android-arm64/-/rollup-android-arm64-4.37.0.tgz",[m
[32m+[m[32m      "integrity": "sha512-6U3SlVyMxezt8Y+/iEBcbp945uZjJwjZimu76xoG7tO1av9VO691z8PkhzQ85ith2I8R2RddEPeSfcbyPfD4hA==",[m
[32m+[m[32m      "cpu": [[m
[32m+[m[32m        "arm64"[m
[32m+[m[32m      ],[m
[32m+[m[32m      "license": "MIT",[m
[32m+[m[32m      "optional": true,[m
[32m+[m[32m      "os": [[m
[32m+[m[32m        "android"[m
[32m+[m[32m      ][m
[32m+[m[32m    },[m
[32m+[m[32m    "node_modules/@rollup/rollup-darwin-arm64": {[m
[32m+[m[32m      "version": "4.37.0",[m
[32m+[m[32m      "resolved": "https://registry.npmjs.org/@rollup/rollup-darwin-arm64/-/rollup-darwin-arm64-4.37.0.tgz",[m
[32m+[m[32m      "integrity": "sha512-+iTQ5YHuGmPt10NTzEyMPbayiNTcOZDWsbxZYR1ZnmLnZxG17ivrPSWFO9j6GalY0+gV3Jtwrrs12DBscxnlYA==",[m
[32m+[m[32m      "cpu": [[m
[32m+[m[32m        "arm64"[m
[32m+[m[32m      ],[m
[32m+[m[32m      "license": "MIT",[m
[32m+[m[32m      "optional": true,[m
[32m+[m[32m      "os": [[m
[32m+[m[32m        "darwin"[m
[32m+[m[32m      ][m
[32m+[m[32m    },[m
[32m+[m[32m    "node_modules/@rollup/rollup-darwin-x64": {[m
[32m+[m[32m      "version": "4.37.0",[m
[32m+[m[32m      "resolved": "https://registry.npmjs.org/@rollup/rollup-darwin-x64/-/rollup-darwin-x64-4.37.0.tgz",[m
[32m+[m[32m      "integrity": "sha512-m8W2UbxLDcmRKVjgl5J/k4B8d7qX2EcJve3Sut7YGrQoPtCIQGPH5AMzuFvYRWZi0FVS0zEY4c8uttPfX6bwYQ==",[m
[32m+[m[32m      "cpu": [[m
[32m+[m[32m        "x64"[m
[32m+[m[32m      ],[m
[32m+[m[32m      "license": "MIT",[m
[32m+[m[32m      "optional": true,[m
[32m+[m[32m      "os": [[m
[32m+[m[32m        "darwin"[m
[32m+[m[32m      ][m
[32m+[m[32m    },[m
[32m+[m[32m    "node_modules/@rollup/rollup-freebsd-arm64": {[m
[32m+[m[32m      "version": "4.37.0",[m
[32m+[m[32m      "resolved": "https://registry.npmjs.org/@rollup/rollup-freebsd-arm64/-/rollup-freebsd-arm64-4.37.0.tgz",[m
[32m+[m[32m      "integrity": "sha512-FOMXGmH15OmtQWEt174v9P1JqqhlgYge/bUjIbiVD1nI1NeJ30HYT9SJlZMqdo1uQFyt9cz748F1BHghWaDnVA==",[m
[32m+[m[32m      "cpu": [[m
[32m+[m[32m        "arm64"[m
[32m+[m[32m      ],[m
[32m+[m[32m      "license": "MIT",[m
[32m+[m[32m      "optional": true,[m
[32m+[m[32m      "os": [[m
[32m+[m[32m        "freebsd"[m
[32m+[m[32m      ][m
[32m+[m[32m    },[m
[32m+[m[32m    "node_modules/@rollup/rollup-freebsd-x64": {[m
[32m+[m[32m      "version": "4.37.0",[m
[32m+[m[32m      "resolved": "https://registry.npmjs.org/@rollup/rollup-freebsd-x64/-/rollup-freebsd-x64-4.37.0.tgz",[m
[32m+[m[32m      "integrity": "sha512-SZMxNttjPKvV14Hjck5t70xS3l63sbVwl98g3FlVVx2YIDmfUIy29jQrsw06ewEYQ8lQSuY9mpAPlmgRD2iSsA==",[m
[32m+[m[32m      "cpu": [[m
[32m+[m[32m        "x64"[m
[32m+[m[32m      ],[m
[32m+[m[32m      "license": "MIT",[m
[32m+[m[32m      "optional": true,[m
[32m+[m[32m      "os": [[m
[32m+[m[32m        "freebsd"[m
[32m+[m[32m      ][m
[32m+[m[32m    },[m
[32m+[m[32m    "node_modules/@rollup/rollup-linux-arm-gnueabihf": {[m
[32m+[m[32m      "version": "4.37.0",[m
[32m+[m[32m      "resolved": "https://registry.npmjs.org/@rollup/rollup-linux-arm-gnueabihf/-/rollup-linux-arm-gnueabihf-4.37.0.tgz",[m
[32m+[m[32m      "integrity": "sha512-hhAALKJPidCwZcj+g+iN+38SIOkhK2a9bqtJR+EtyxrKKSt1ynCBeqrQy31z0oWU6thRZzdx53hVgEbRkuI19w==",[m
[32m+[m[32m      "cpu": [[m
[32m+[m[32m        "arm"[m
[32m+[m[32m      ],[m
[32m+[m[32m      "license": "MIT",[m
[32m+[m[32m      "optional": true,[m
[32m+[m[32m      "os": [[m
[32m+[m[32m        "linux"[m
[32m+[m[32m      ][m
[32m+[m[32m    },[m
[32m+[m[32m    "node_modules/@rollup/rollup-linux-arm-musleabihf": {[m
[32m+[m[32m      "version": "4.37.0",[m
[32m+[m[32m      "resolved": "https://registry.npmjs.org/@rollup/rollup-linux-arm-musleabihf/-/rollup-linux-arm-musleabihf-4.37.0.tgz",[m
[32m+[m[32m      "integrity": "sha512-jUb/kmn/Gd8epbHKEqkRAxq5c2EwRt0DqhSGWjPFxLeFvldFdHQs/n8lQ9x85oAeVb6bHcS8irhTJX2FCOd8Ag==",[m
[32m+[m[32m      "cpu": [[m
[32m+[m[32m        "arm"[m
[32m+[m[32m      ],[m
[32m+[m[32m      "license": "MIT",[m
[32m+[m[32m      "optional": true,[m
[32m+[m[32m      "os": [[m
[32m+[m[32m        "linux"[m
[32m+[m[32m      ][m
[32m+[m[32m    },[m
[32m+[m[32m    "node_modules/@rollup/rollup-linux-arm64-gnu": {[m
[32m+[m[32m      "version": "4.37.0",[m
[32m+[m[32m      "resolved": "https://registry.npmjs.org/@rollup/rollup-linux-arm64-gnu/-/rollup-linux-arm64-gnu-4.37.0.tgz",[m
[32m+[m[32m      "integrity": "sha512-oNrJxcQT9IcbcmKlkF+Yz2tmOxZgG9D9GRq+1OE6XCQwCVwxixYAa38Z8qqPzQvzt1FCfmrHX03E0pWoXm1DqA==",[m
[32m+[m[32m      "cpu": [[m
[32m+[m[32m        "arm64"[m
[32m+[m[32m      ],[m
[32m+[m[32m      "license": "MIT",[m
[32m+[m[32m      "optional": true,[m
[32m+[m[32m      "os": [[m
[32m+[m[32m        "linux"[m
[32m+[m[32m      ][m
[32m+[m[32m    },[m
[32m+[m[32m    "node_modules/@rollup/rollup-linux-arm64-musl": {[m
[32m+[m[32m      "version": "4.37.0",[m
[32m+[m[32m      "resolved": "https://registry.npmjs.org/@rollup/rollup-linux-arm64-musl/-/rollup-linux-arm64-musl-4.37.0.tgz",[m
[32m+[m[32m      "integrity": "sha512-pfxLBMls+28Ey2enpX3JvjEjaJMBX5XlPCZNGxj4kdJyHduPBXtxYeb8alo0a7bqOoWZW2uKynhHxF/MWoHaGQ==",[m
[32m+[m[32m      "cpu": [[m
[32m+[m[32m        "arm64"[m
[32m+[m[32m      ],[m
[32m+[m[32m      "license": "MIT",[m
[32m+[m[32m      "optional": true,[m
[32m+[m[32m      "os": [[m
[32m+[m[32m        "linux"[m
[32m+[m[32m      ][m
[32m+[m[32m    },[m
[32m+[m[32m    "node_modules/@rollup/rollup-linux-loongarch64-gnu": {[m
[32m+[m[32m      "version": "4.37.0",[m
[32m+[m[32m      "resolved": "https://registry.npmjs.org/@rollup/rollup-linux-loongarch64-gnu/-/rollup-linux-loongarch64-gnu-4.37.0.tgz",[m
[32m+[m[32m      "integrity": "sha512-yCE0NnutTC/7IGUq/PUHmoeZbIwq3KRh02e9SfFh7Vmc1Z7atuJRYWhRME5fKgT8aS20mwi1RyChA23qSyRGpA==",[m
[32m+[m[32m      "cpu": [[m
[32m+[m[32m        "loong64"[m
[32m+[m[32m      ],[m
[32m+[m[32m      "license": "MIT",[m
[32m+[m[32m      "optional": true,[m
[32m+[m[32m      "os": [[m
[32m+[m[32m        "linux"[m
[32m+[m[32m      ][m
[32m+[m[32m    },[m
[32m+[m[32m    "node_modules/@rollup/rollup-linux-powerpc64le-gnu": {[m
[32m+[m[32m      "version": "4.37.0",[m
[32m+[m[32m      "resolved": "https://registry.npmjs.org/@rollup/rollup-linux-powerpc64le-gnu/-/rollup-linux-powerpc64le-gnu-4.37.0.tgz",[m
[32m+[m[32m      "integrity": "sha512-NxcICptHk06E2Lh3a4Pu+2PEdZ6ahNHuK7o6Np9zcWkrBMuv21j10SQDJW3C9Yf/A/P7cutWoC/DptNLVsZ0VQ==",[m
[32m+[m[32m      "cpu": [[m
[32m+[m[32m        "ppc64"[m
[32m+[m[32m      ],[m
[32m+[m[32m      "license": "MIT",[m
[32m+[m[32m      "optional": true,[m
[32m+[m[32m      "os": [[m
[32m+[m[32m        "linux"[m
[32m+[m[32m      ][m
[32m+[m[32m    },[m
[32m+[m[32m    "node_modules/@rollup/rollup-linux-riscv64-gnu": {[m
[32m+[m[32m      "version": "4.37.0",[m
[32m+[m[32m      "resolved": "https://registry.npmjs.org/@rollup/rollup-linux-riscv64-gnu/-/rollup-linux-riscv64-gnu-4.37.0.tgz",[m
[32m+[m[32m      "integrity": "sha512-PpWwHMPCVpFZLTfLq7EWJWvrmEuLdGn1GMYcm5MV7PaRgwCEYJAwiN94uBuZev0/J/hFIIJCsYw4nLmXA9J7Pw==",[m
[32m+[m[32m      "cpu": [[m
[32m+[m[32m        "riscv64"[m
[32m+[m[32m      ],[m
[32m+[m[32m      "license": "MIT",[m
[32m+[m[32m      "optional": true,[m
[32m+[m[32m      "os": [[m
[32m+[m[32m        "linux"[m
[32m+[m[32m      ][m
[32m+[m[32m    },[m
[32m+[m[32m    "node_modules/@rollup/rollup-linux-riscv64-musl": {[m
[32m+[m[32m      "version": "4.37.0",[m
[32m+[m[32m      "resolved": "https://registry.npmjs.org/@rollup/rollup-linux-riscv64-musl/-/rollup-linux-riscv64-musl-4.37.0.tgz",[m
[32m+[m[32m      "integrity": "sha512-DTNwl6a3CfhGTAOYZ4KtYbdS8b+275LSLqJVJIrPa5/JuIufWWZ/QFvkxp52gpmguN95eujrM68ZG+zVxa8zHA==",[m
[32m+[m[32m      "cpu": [[m
[32m+[m[32m        "riscv64"[m
[32m+[m[32m      ],[m
[32m+[m[32m      "license": "MIT",[m
[32m+[m[32m      "optional": true,[m
[32m+[m[32m      "os": [[m
[32m+[m[32m        "linux"[m
[32m+[m[32m      ][m
[32m+[m[32m    },[m
[32m+[m[32m    "node_modules/@rollup/rollup-linux-s390x-gnu": {[m
[32m+[m[32m      "version": "4.37.0",[m
[32m+[m[32m      "resolved": "https://registry.npmjs.org/@rollup/rollup-linux-s390x-gnu/-/rollup-linux-s390x-gnu-4.37.0.tgz",[m
[32m+[m[32m      "integrity": "sha512-hZDDU5fgWvDdHFuExN1gBOhCuzo/8TMpidfOR+1cPZJflcEzXdCy1LjnklQdW8/Et9sryOPJAKAQRw8Jq7Tg+A==",[m
[32m+[m[32m      "cpu": [[m
[32m+[m[32m        "s390x"[m
[32m+[m[32m      ],[m
[32m+[m[32m      "license": "MIT",[m
[32m+[m[32m      "optional": true,[m
[32m+[m[32m      "os": [[m
[32m+[m[32m        "linux"[m
[32m+[m[32m      ][m
[32m+[m[32m    },[m
[32m+[m[32m    "node_modules/@rollup/rollup-linux-x64-gnu": {[m
[32m+[m[32m      "version": "4.37.0",[m
[32m+[m[32m      "resolved": "https://registry.npmjs.org/@rollup/rollup-linux-x64-gnu/-/rollup-linux-x64-gnu-4.37.0.tgz",[m
[32m+[m[32m      "integrity": "sha512-pKivGpgJM5g8dwj0ywBwe/HeVAUSuVVJhUTa/URXjxvoyTT/AxsLTAbkHkDHG7qQxLoW2s3apEIl26uUe08LVQ==",[m
[32m+[m[32m      "cpu": [[m
[32m+[m[32m        "x64"[m
[32m+[m[32m      ],[m
[32m+[m[32m      "license": "MIT",[m
[32m+[m[32m      "optional": true,[m
[32m+[m[32m      "os": [[m
[32m+[m[32m        "linux"[m
[32m+[m[32m      ][m
[32m+[m[32m    },[m
[32m+[m[32m    "node_modules/@rollup/rollup-linux-x64-musl": {[m
[32m+[m[32m      "version": "4.37.0",[m
[32m+[m[32m      "resolved": "https://registry.npmjs.org/@rollup/rollup-linux-x64-musl/-/rollup-linux-x64-musl-4.37.0.tgz",[m
[32m+[m[32m      "integrity": "sha512-E2lPrLKE8sQbY/2bEkVTGDEk4/49UYRVWgj90MY8yPjpnGBQ+Xi1Qnr7b7UIWw1NOggdFQFOLZ8+5CzCiz143w==",[m
[32m+[m[32m      "cpu": [[m
[32m+[m[32m        "x64"[m
[32m+[m[32m      ],[m
[32m+[m[32m      "license": "MIT",[m
[32m+[m[32m      "optional": true,[m
[32m+[m[32m      "os": [[m
[32m+[m[32m        "linux"[m
[32m+[m[32m      ][m
[32m+[m[32m    },[m
[32m+[m[32m    "node_modules/@rollup/rollup-win32-arm64-msvc": {[m
[32m+[m[32m      "version": "4.37.0",[m
[32m+[m[32m      "resolved": "https://registry.npmjs.org/@rollup/rollup-win32-arm64-msvc/-/rollup-win32-arm64-msvc-4.37.0.tgz",[m
[32m+[m[32m      "integrity": "sha512-Jm7biMazjNzTU4PrQtr7VS8ibeys9Pn29/1bm4ph7CP2kf21950LgN+BaE2mJ1QujnvOc6p54eWWiVvn05SOBg==",[m
[32m+[m[32m      "cpu": [[m
[32m+[m[32m        "arm64"[m
[32m+[m[32m      ],[m
[32m+[m[32m      "license": "MIT",[m
[32m+[m[32m      "optional": true,[m
[32m+[m[32m      "os": [[m
[32m+[m[32m        "win32"[m
[32m+[m[32m      ][m
[32m+[m[32m    },[m
[32m+[m[32m    "node_modules/@rollup/rollup-win32-ia32-msvc": {[m
[32m+[m[32m      "version": "4.37.0",[m
[32m+[m[32m      "resolved": "https://registry.npmjs.org/@rollup/rollup-win32-ia32-msvc/-/rollup-win32-ia32-msvc-4.37.0.tgz",[m
[32m+[m[32m      "integrity": "sha512-e3/1SFm1OjefWICB2Ucstg2dxYDkDTZGDYgwufcbsxTHyqQps1UQf33dFEChBNmeSsTOyrjw2JJq0zbG5GF6RA==",[m
[32m+[m[32m      "cpu": [[m
[32m+[m[32m        "ia32"[m
[32m+[m[32m      ],[m
[32m+[m[32m      "license": "MIT",[m
[32m+[m[32m      "optional": true,[m
[32m+[m[32m      "os": [[m
[32m+[m[32m        "win32"[m
[32m+[m[32m      ][m
[32m+[m[32m    },[m
[32m+[m[32m    "node_modules/@rollup/rollup-win32-x64-msvc": {[m
[32m+[m[32m      "version": "4.37.0",[m
[32m+[m[32m      "resolved": "https://registry.npmjs.org/@rollup/rollup-win32-x64-msvc/-/rollup-win32-x64-msvc-4.37.0.tgz",[m
[32m+[m[32m      "integrity": "sha512-LWbXUBwn/bcLx2sSsqy7pK5o+Nr+VCoRoAohfJ5C/aBio9nfJmGQqHAhU6pwxV/RmyTk5AqdySma7uwWGlmeuA==",[m
[32m+[m[32m      "cpu": [[m
[32m+[m[32m        "x64"[m
[32m+[m[32m      ],[m
[32m+[m[32m      "license": "MIT",[m
[32m+[m[32m      "optional": true,[m
[32m+[m[32m      "os": [[m
[32m+[m[32m        "win32"[m
[32m+[m[32m      ][m
[32m+[m[32m    },[m
[32m+[m[32m    "node_modules/@tailwindcss/node": {[m
[32m+[m[32m      "version": "4.0.15",[m
[32m+[m[32m      "resolved": "https://registry.npmjs.org/@tailwindcss/node/-/node-4.0.15.tgz",[m
[32m+[m[32m      "integrity": "sha512-IODaJjNmiasfZX3IoS+4Em3iu0fD2HS0/tgrnkYfW4hyUor01Smnr5eY3jc4rRgaTDrJlDmBTHbFO0ETTDaxWA==",[m
[32m+[m[32m      "license": "MIT",[m
[32m+[m[32m      "dependencies": {[m
[32m+[m[32m        "enhanced-resolve": "^5.18.1",[m
[32m+[m[32m        "jiti": "^2.4.2",[m
[32m+[m[32m        "tailwindcss": "4.0.15"[m
[32m+[m[32m      }[m
[32m+[m[32m    },[m
[32m+[m[32m    "node_modules/@tailwindcss/oxide": {[m
[32m+[m[32m      "version": "4.0.15",[m
[32m+[m[32m      "resolved": "https://registry.npmjs.org/@tailwindcss/oxide/-/oxide-4.0.15.tgz",[m
[32m+[m[32m      "integrity": "sha512-e0uHrKfPu7JJGMfjwVNyt5M0u+OP8kUmhACwIRlM+JNBuReDVQ63yAD1NWe5DwJtdaHjugNBil76j+ks3zlk6g==",[m
[32m+[m[32m      "license": "MIT",[m
[32m+[m[32m      "engines": {[m
[32m+[m[32m        "node": ">= 10"[m
[32m+[m[32m      },[m
[32m+[m[32m      "optionalDependencies": {[m
[32m+[m[32m        "@tailwindcss/oxide-android-arm64": "4.0.15",[m
[32m+[m[32m        "@tailwindcss/oxide-darwin-arm64": "4.0.15",[m
[32m+[m[32m        "@tailwindcss/oxide-darwin-x64": "4.0.15",[m
[32m+[m[32m        "@tailwindcss/oxide-freebsd-x64": "4.0.15",[m
[32m+[m[32m        "@tailwindcss/oxide-linux-arm-gnueabihf": "4.0.15",[m
[32m+[m[32m        "@tailwindcss/oxide-linux-arm64-gnu": "4.0.15",[m
[32m+[m[32m        "@tailwindcss/oxide-linux-arm64-musl": "4.0.15",[m
[32m+[m[32m        "@tailwindcss/oxide-linux-x64-gnu": "4.0.15",[m
[32m+[m[32m        "@tailwindcss/oxide-linux-x64-musl": "4.0.15",[m
[32m+[m[32m        "@tailwindcss/oxide-win32-arm64-msvc": "4.0.15",[m
[32m+[m[32m        "@tailwindcss/oxide-win32-x64-msvc": "4.0.15"[m
[32m+[m[32m      }[m
[32m+[m[32m    },[m
[32m+[m[32m    "node_modules/@tailwindcss/oxide-android-arm64": {[m
[32m+[m[32m      "version": "4.0.15",[m
[32m+[m[32m      "resolved": "https://registry.npmjs.org/@tailwindcss/oxide-android-arm64/-/oxide-android-arm64-4.0.15.tgz",[m
[32m+[m[32m      "integrity": "sha512-EBuyfSKkom7N+CB3A+7c0m4+qzKuiN0WCvzPvj5ZoRu4NlQadg/mthc1tl5k9b5ffRGsbDvP4k21azU4VwVk3Q==",[m
[32m+[m[32m      "cpu": [[m
[32m+[m[32m        "arm64"[m
[32m+[m[32m      ],[m
[32m+[m[32m      "license": "MIT",[m
[32m+[m[32m      "optional": true,[m
[32m+[m[32m      "os": [[m
[32m+[m[32m        "android"[m
[32m+[m[32m      ],[m
[32m+[m[32m      "engines": {[m
[32m+[m[32m        "node": ">= 10"[m
[32m+[m[32m      }[m
[32m+[m[32m    },[m
[32m+[m[32m    "node_modules/@tailwindcss/oxide-darwin-arm64": {[m
[32m+[m[32m      "version": "4.0.15",[m
[32m+[m[32m      "resolved": "https://registry.npmjs.org/@tailwindcss/oxide-darwin-arm64/-/oxide-darwin-arm64-4.0.15.tgz",[m
[32m+[m[32m      "integrity": "sha512-ObVAnEpLepMhV9VoO0JSit66jiN5C4YCqW3TflsE9boo2Z7FIjV80RFbgeL2opBhtxbaNEDa6D0/hq/EP03kgQ==",[m
[32m+[m[32m      "cpu": [[m
[32m+[m[32m        "arm64"[m
[32m+[m[32m      ],[m
[32m+[m[32m      "license": "MIT",[m
[32m+[m[32m      "optional": true,[m
[32m+[m[32m      "os": [[m
[32m+[m[32m        "darwin"[m
[32m+[m[32m      ],[m
[32m+[m[32m      "engines": {[m
[32m+[m[32m        "node": ">= 10"[m
[32m+[m[32m      }[m
[32m+[m[32m    },[m
[32m+[m[32m    "node_modules/@tailwindcss/oxide-darwin-x64": {[m
[32m+[m[32m      "version": "4.0.15",[m
[32m+[m[32m      "resolved": "https://registry.npmjs.org/@tailwindcss/oxide-darwin-x64/-/oxide-darwin-x64-4.0.15.tgz",[m
[32m+[m[32m      "integrity": "sha512-IElwoFhUinOr9MyKmGTPNi1Rwdh68JReFgYWibPWTGuevkHkLWKEflZc2jtI5lWZ5U9JjUnUfnY43I4fEXrc4g==",[m
[32m+[m[32m      "cpu": [[m
[32m+[m[32m        "x64"[m
[32m+[m[32m      ],[m
[32m+[m[32m      "license": "MIT",[m
[32m+[m[32m      "optional": true,[m
[32m+[m[32m      "os": [[m
[32m+[m[32m        "darwin"[m
[32m+[m[32m      ],[m
[32m+[m[32m      "engines": {[m
[32m+[m[32m        "node": ">= 10"[m
[32m+[m[32m      }[m
[32m+[m[32m    },[m
[32m+[m[32m    "node_modules/@tailwindcss/oxide-freebsd-x64": {[m
[32m+[m[32m      "version": "4.0.15",[m
[32m+[m[32m      "resolved": "https://registry.npmjs.org/@tailwindcss/oxide-freebsd-x64/-/oxide-freebsd-x64-4.0.15.tgz",[m
[32m+[m[32m      "integrity": "sha512-6BLLqyx7SIYRBOnTZ8wgfXANLJV5TQd3PevRJZp0vn42eO58A2LykRKdvL1qyPfdpmEVtF+uVOEZ4QTMqDRAWA==",[m
[32m+[m[32m      "cpu": [[m
[32m+[m[32m        "x64"[m
[32m+[m[32m      ],[m
[32m+[m[32m      "license": "MIT",[m
[32m+[m[32m      "optional": true,[m
[32m+[m[32m      "os": [[m
[32m+[m[32m        "freebsd"[m
[32m+[m[32m      ],[m
[32m+[m[32m      "engines": {[m
[32m+[m[32m        "node": ">= 10"[m
[32m+[m[32m      }[m
[32m+[m[32m    },[m
[32m+[m[32m    "node_modules/@tailwindcss/oxide-linux-arm-gnueabihf": {[m
[32m+[m[32m      "version": "4.0.15",[m
[32m+[m[32m      "resolved": "https://registry.npmjs.org/@tailwindcss/oxide-linux-arm-gnueabihf/-/oxide-linux-arm-gnueabihf-4.0.15.tgz",[m
[32m+[m[32m      "integrity": "sha512-Zy63EVqO9241Pfg6G0IlRIWyY5vNcWrL5dd2WAKVJZRQVeolXEf1KfjkyeAAlErDj72cnyXObEZjMoPEKHpdNw==",[m
[32m+[m[32m      "cpu": [[m
[32m+[m[32m        "arm"[m
[32m+[m[32m      ],[m
[32m+[m[32m      "license": "MIT",[m
[32m+[m[32m      "optional": true,[m
[32m+[m[32m      "os": [[m
[32m+[m[32m        "linux"[m
[32m+[m[32m      ],[m
[32m+[m[32m      "engines": {[m
[32m+[m[32m        "node": ">= 10"[m
[32m+[m[32m      }[m
[32m+[m[32m    },[m
[32m+[m[32m    "node_modules/@tailwindcss/oxide-linux-arm64-gnu": {[m
[32m+[m[32m      "version": "4.0.15",[m
[32m+[m[32m      "resolved": "https://registry.npmjs.org/@tailwindcss/oxide-linux-arm64-gnu/-/oxide-linux-arm64-gnu-4.0.15.tgz",[m
[32m+[m[32m      "integrity": "sha512-2NemGQeaTbtIp1Z2wyerbVEJZTkAWhMDOhhR5z/zJ75yMNf8yLnE+sAlyf6yGDNr+1RqvWrRhhCFt7i0CIxe4Q==",[m
[32m+[m[32m      "cpu": [[m
[32m+[m[32m        "arm64"[m
[32m+[m[32m      ],[m
[32m+[m[32m      "license": "MIT",[m
[32m+[m[32m      "optional": true,[m
[32m+[m[32m      "os": [[m
[32m+[m[32m        "linux"[m
[32m+[m[32m      ],[m
[32m+[m[32m      "engines": {[m
[32m+[m[32m        "node": ">= 10"[m
[32m+[m[32m      }[m
[32m+[m[32m    },[m
[32m+[m[32m    "node_modules/@tailwindcss/oxide-linux-arm64-musl": {[m
[32m+[m[32m      "version": "4.0.15",[m
[32m+[m[32m      "resolved": "https://registry.npmjs.org/@tailwindcss/oxide-linux-arm64-musl/-/oxide-linux-arm64-musl-4.0.15.tgz",[m
[32m+[m[32m      "integrity": "sha512-342GVnhH/6PkVgKtEzvNVuQ4D+Q7B7qplvuH20Cfz9qEtydG6IQczTZ5IT4JPlh931MG1NUCVxg+CIorr1WJyw==",[m
[32m+[m[32m      "cpu": [[m
[32m+[m[32m        "arm64"[m
[32m+[m[32m      ],[m
[32m+[m[32m      "license": "MIT",[m
[32m+[m[32m      "optional": true,[m
[32m+[m[32m      "os": [[m
[32m+[m[32m        "linux"[m
[32m+[m[32m      ],[m
[32m+[m[32m      "engines": {[m
[32m+[m[32m        "node": ">= 10"[m
[32m+[m[32m      }[m
[32m+[m[32m    },[m
[32m+[m[32m    "node_modules/@tailwindcss/oxide-linux-x64-gnu": {[m
[32m+[m[32m      "version": "4.0.15",[m
[32m+[m[32m      "resolved": "https://registry.npmjs.org/@tailwindcss/oxide-linux-x64-gnu/-/oxide-linux-x64-gnu-4.0.15.tgz",[m
[32m+[m[32m      "integrity": "sha512-g76GxlKH124RuGqacCEFc2nbzRl7bBrlC8qDQMiUABkiifDRHOIUjgKbLNG4RuR9hQAD/MKsqZ7A8L08zsoBrw==",[m
[32m+[m[32m      "cpu": [[m
[32m+[m[32m        "x64"[m
[32m+[m[32m      ],[m
[32m+[m[32m      "license": "MIT",[m
[32m+[m[32m      "optional": true,[m
[32m+[m[32m      "os": [[m
[32m+[m[32m        "linux"[m
[32m+[m[32m      ],[m
[32m+[m[32m      "engines": {[m
[32m+[m[32m        "node": ">= 10"[m
[32m+[m[32m      }[m
[32m+[m[32m    },[m
[32m+[m[32m    "node_modules/@tailwindcss/oxide-linux-x64-musl": {[m
[32m+[m[32m      "version": "4.0.15",[m
[32m+[m[32m      "resolved": "https://registry.npmjs.org/@tailwindcss/oxide-linux-x64-musl/-/oxide-linux-x64-musl-4.0.15.tgz",[m
[32m+[m[32m      "integrity": "sha512-Gg/Y1XrKEvKpq6WeNt2h8rMIKOBj/W3mNa5NMvkQgMC7iO0+UNLrYmt6zgZufht66HozNpn+tJMbbkZ5a3LczA==",[m
[32m+[m[32m      "cpu": [[m
[32m+[m[32m        "x64"[m
[32m+[m[32m      ],[m
[32m+[m[32m      "license": "MIT",[m
[32m+[m[32m      "optional": true,[m
[32m+[m[32m      "os": [[m
[32m+[m[32m        "linux"[m
[32m+[m[32m      ],[m
[32m+[m[32m      "engines": {[m
[32m+[m[32m        "node": ">= 10"[m
[32m+[m[32m      }[m
[32m+[m[32m    },[m
[32m+[m[32m    "node_modules/@tailwindcss/oxide-win32-arm64-msvc": {[m
[32m+[m[32m      "version": "4.0.15",[m
[32m+[m[32m      "resolved": "https://registry.npmjs.org/@tailwindcss/oxide-win32-arm64-msvc/-/oxide-win32-arm64-msvc-4.0.15.tgz",[m
[32m+[m[32m      "integrity": "sha512-7QtSSJwYZ7ZK1phVgcNZpuf7c7gaCj8Wb0xjliligT5qCGCp79OV2n3SJummVZdw4fbTNKUOYMO7m1GinppZyA==",[m
[32m+[m[32m      "cpu": [[m
[32m+[m[32m        "arm64"[m
[32m+[m[32m      ],[m
[32m+[m[32m      "license": "MIT",[m
[32m+[m[32m      "optional": true,[m
[32m+[m[32m      "os": [[m
[32m+[m[32m        "win32"[m
[32m+[m[32m      ],[m
[32m+[m[32m      "engines": {[m
[32m+[m[32m        "node": ">= 10"[m
[32m+[m[32m      }[m
[32m+[m[32m    },[m
[32m+[m[32m    "node_modules/@tailwindcss/oxide-win32-x64-msvc": {[m
[32m+[m[32m      "version": "4.0.15",[m
[32m+[m[32m      "resolved": "https://registry.npmjs.org/@tailwindcss/oxide-win32-x64-msvc/-/oxide-win32-x64-msvc-4.0.15.tgz",[m
[32m+[m[32m      "integrity": "sha512-JQ5H+5MLhOjpgNp6KomouE0ZuKmk3hO5h7/ClMNAQ8gZI2zkli3IH8ZqLbd2DVfXDbdxN2xvooIEeIlkIoSCqw==",[m
[32m+[m[32m      "cpu": [[m
[32m+[m[32m        "x64"[m
[32m+[m[32m      ],[m
[32m+[m[32m      "license": "MIT",[m
[32m+[m[32m      "optional": true,[m
[32m+[m[32m      "os": [[m
[32m+[m[32m        "win32"[m
[32m+[m[32m      ],[m
[32m+[m[32m      "engines": {[m
[32m+[m[32m        "node": ">= 10"[m
[32m+[m[32m      }[m
[32m+[m[32m    },[m
[32m+[m[32m    "node_modules/@tailwindcss/vite": {[m
[32m+[m[32m      "version": "4.0.15",[m
[32m+[m[32m      "resolved": "https://registry.npmjs.org/@tailwindcss/vite/-/vite-4.0.15.tgz",[m
[32m+[m[32m      "integrity": "sha512-JRexava80NijI8cTcLXNM3nQL5A0ptTHI8oJLLe8z1MpNB6p5J4WCdJJP8RoyHu8/eB1JzEdbpH86eGfbuaezQ==",[m
[32m+[m[32m      "license": "MIT",[m
[32m+[m[32m      "dependencies": {[m
[32m+[m[32m        "@tailwindcss/node": "4.0.15",[m
[32m+[m[32m        "@tailwindcss/oxide": "4.0.15",[m
[32m+[m[32m        "lightningcss": "1.29.2",[m
[32m+[m[32m        "tailwindcss": "4.0.15"[m
[32m+[m[32m      },[m
[32m+[m[32m      "peerDependencies": {[m
[32m+[m[32m        "vite": "^5.2.0 || ^6"[m
[32m+[m[32m      }[m
[32m+[m[32m    },[m
[32m+[m[32m    "node_modules/@types/babel__core": {[m
[32m+[m[32m      "version": "7.20.5",[m
[32m+[m[32m      "resolved": "https://registry.npmjs.org/@types/babel__core/-/babel__core-7.20.5.tgz",[m
[32m+[m[32m      "integrity": "sha512-qoQprZvz5wQFJwMDqeseRXWv3rqMvhgpbXFfVyWhbx9X47POIA6i/+dXefEmZKoAgOaTdaIgNSMqMIU61yRyzA==",[m
[32m+[m[32m      "dev": true,[m
[32m+[m[32m      "license": "MIT",[m
[32m+[m[32m      "dependencies": {[m
[32m+[m[32m        "@babel/parser": "^7.20.7",[m
[32m+[m[32m        "@babel/types": "^7.20.7",[m
[32m+[m[32m        "@types/babel__generator": "*",[m
[32m+[m[32m        "@types/babel__template": "*",[m
[32m+[m[32m        "@types/babel__traverse": "*"[m
[32m+[m[32m      }[m
[32m+[m[32m    },[m
[32m+[m[32m    "node_modules/@types/babel__generator": {[m
[32m+[m[32m      "version": "7.6.8",[m
[32m+[m[32m      "resolved": "https://registry.npmjs.org/@types/babel__generator/-/babel__generator-7.6.8.tgz",[m
[32m+[m[32m      "integrity": "sha512-ASsj+tpEDsEiFr1arWrlN6V3mdfjRMZt6LtK/Vp/kreFLnr5QH5+DhvD5nINYZXzwJvXeGq+05iUXcAzVrqWtw==",[m
[32m+[m[32m      "dev": true,[m
[32m+[m[32m      "license": "MIT",[m
[32m+[m[32m      "dependencies": {[m
[32m+[m[32m        "@babel/types": "^7.0.0"[m
[32m+[m[32m      }[m
[32m+[m[32m    },[m
[32m+[m[32m    "node_modules/@types/babel__template": {[m
[32m+[m[32m      "version": "7.4.4",[m
[32m+[m[32m      "resolved": "https://registry.npmjs.org/@types/babel__template/-/babel__template-7.4.4.tgz",[m
[32m+[m[32m      "integrity": "sha512-h/NUaSyG5EyxBIp8YRxo4RMe2/qQgvyowRwVMzhYhBCONbW8PUsg4lkFMrhgZhUe5z3L3MiLDuvyJ/CaPa2A8A==",[m
[32m+[m[32m      "dev": true,[m
[32m+[m[32m      "license": "MIT",[m
[32m+[m[32m      "dependencies": {[m
[32m+[m[32m        "@babel/parser": "^7.1.0",[m
[32m+[m[32m        "@babel/types": "^7.0.0"[m
[32m+[m[32m      }[m
[32m+[m[32m    },[m
[32m+[m[32m    "node_modules/@types/babel__traverse": {[m
[32m+[m[32m      "version": "7.20.6",[m
[32m+[m[32m      "resolved": "https://registry.npmjs.org/@types/babel__traverse/-/babel__traverse-7.20.6.tgz",[m
[32m+[m[32m      "integrity": "sha512-r1bzfrm0tomOI8g1SzvCaQHo6Lcv6zu0EA+W2kHrt8dyrHQxGzBBL4kdkzIS+jBMV+EYcMAEAqXqYaLJq5rOZg==",[m
[32m+[m[32m      "dev": true,[m
[32m+[m[32m      "license": "MIT",[m
[32m+[m[32m      "dependencies": {[m
[32m+[m[32m        "@babel/types": "^7.20.7"[m
[32m+[m[32m      }[m
[32m+[m[32m    },[m
[32m+[m[32m    "node_modules/@types/cookie": {[m
[32m+[m[32m      "version": "0.6.0",[m
[32m+[m[32m      "resolved": "https://registry.npmjs.org/@types/cookie/-/cookie-0.6.0.tgz",[m
[32m+[m[32m      "integrity": "sha512-4Kh9a6B2bQciAhf7FSuMRRkUWecJgJu9nPnx3yzpsfXX/c50REIqpHY4C82bXP90qrLtXtkDxTZosYO3UpOwlA==",[m
[32m+[m[32m      "license": "MIT"[m
[32m+[m[32m    },[m
[32m+[m[32m    "node_modules/@types/estree": {[m
[32m+[m[32m      "version": "1.0.6",[m
[32m+[m[32m      "resolved": "https://registry.npmjs.org/@types/estree/-/estree-1.0.6.tgz",[m
[32m+[m[32m      "integrity": "sha512-AYnb1nQyY49te+VRAVgmzfcgjYS91mY5P0TKUDCLEM+gNnA+3T6rWITXRLYCpahpqSQbN5cE+gHpnPyXjHWxcw==",[m
[32m+[m[32m      "license": "MIT"[m
[32m+[m[32m    },[m
[32m+[m[32m    "node_modules/@types/json-schema": {[m
[32m+[m[32m      "version": "7.0.15",[m
[32m+[m[32m      "resolved": "https://registry.npmjs.org/@types/json-schema/-/json-schema-7.0.15.tgz",[m
[32m+[m[32m      "integrity": "sha512-5+fP8P8MFNC+AyZCDxrB2pkZFPGzqQWUzpSeuuVLvm8VMcorNYavBqoFcxK8bQz4Qsbn4oUEEem4wDLfcysGHA==",[m
[32m+[m[32m      "dev": true,[m
[32m+[m[32m      "license": "MIT"[m
[32m+[m[32m    },[m
[32m+[m[32m    "node_modules/@types/react": {[m
[32m+[m[32m      "version": "19.0.12",[m
[32m+[m[32m      "resolved": "https://registry.npmjs.org/@types/react/-/react-19.0.12.tgz",[m
[32m+[m[32m      "integrity": "sha512-V6Ar115dBDrjbtXSrS+/Oruobc+qVbbUxDFC1RSbRqLt5SYvxxyIDrSC85RWml54g+jfNeEMZhEj7wW07ONQhA==",[m
[32m+[m[32m      "dev": true,[m
[32m+[m[32m      "license": "MIT",[m
[32m+[m[32m      "dependencies": {[m
[32m+[m[32m        "csstype": "^3.0.2"[m
[32m+[m[32m      }[m
[32m+[m[32m    },[m
[32m+[m[32m    "node_modules/@types/react-dom": {[m
[32m+[m[32m      "version": "19.0.4",[m
[32m+[m[32m      "resolved": "https://registry.npmjs.org/@types/react-dom/-/react-dom-19.0.4.tgz",[m
[32m+[m[32m      "integrity": "sha512-4fSQ8vWFkg+TGhePfUzVmat3eC14TXYSsiiDSLI0dVLsrm9gZFABjPy/Qu6TKgl1tq1Bu1yDsuQgY3A3DOjCcg==",[m
[32m+[m[32m      "dev": true,[m
[32m+[m[32m      "license": "MIT",[m
[32m+[m[32m      "peerDependencies": {[m
[32m+[m[32m        "@types/react": "^19.0.0"[m
[32m+[m[32m      }[m
[32m+[m[32m    },[m
[32m+[m[32m    "node_modules/@vitejs/plugin-react": {[m
[32m+[m[32m      "version": "4.3.4",[m
[32m+[m[32m      "resolved": "https://registry.npmjs.org/@vitejs/plugin-react/-/plugin-react-4.3.4.tgz",[m
[32m+[m[32m      "integrity": "sha512-SCCPBJtYLdE8PX/7ZQAs1QAZ8Jqwih+0VBLum1EGqmCCQal+MIUqLCzj3ZUy8ufbC0cAM4LRlSTm7IQJwWT4ug==",[m
[32m+[m[32m      "dev": true,[m
[32m+[m[32m      "license": "MIT",[m
[32m+[m[32m      "dependencies": {[m
[32m+[m[32m        "@babel/core": "^7.26.0",[m
[32m+[m[32m        "@babel/plugin-transform-react-jsx-self": "^7.25.9",[m
[32m+[m[32m        "@babel/plugin-transform-react-jsx-source": "^7.25.9",[m
[32m+[m[32m        "@types/babel__core": "^7.20.5",[m
[32m+[m[32m        "react-refresh": "^0.14.2"[m
[32m+[m[32m      },[m
[32m+[m[32m      "engines": {[m
[32m+[m[32m        "node": "^14.18.0 || >=16.0.0"[m
[32m+[m[32m      },[m
[32m+[m[32m      "peerDependencies": {[m
[32m+[m[32m        "vite": "^4.2.0 || ^5.0.0 || ^6.0.0"[m
[32m+[m[32m      }[m
[32m+[m[32m    },[m
[32m+[m[32m    "node_modules/acorn": {[m
[32m+[m[32m      "version": "8.14.1",[m
[32m+[m[32m      "resolved": "https://registry.npmjs.org/acorn/-/acorn-8.14.1.tgz",[m
[32m+[m[32m      "integrity": "sha512-OvQ/2pUDKmgfCg++xsTX1wGxfTaszcHVcTctW4UJB4hibJx2HXxxO5UmVgyjMa+ZDsiaf5wWLXYpRWMmBI0QHg==",[m
[32m+[m[32m      "dev": true,[m
[32m+[m[32m      "license": "MIT",[m
[32m+[m[32m      "bin": {[m
[32m+[m[32m        "acorn": "bin/acorn"[m
[32m+[m[32m      },[m
[32m+[m[32m      "engines": {[m
[32m+[m[32m        "node": ">=0.4.0"[m
[32m+[m[32m      }[m
[32m+[m[32m    },[m
[32m+[m[32m    "node_modules/acorn-jsx": {[m
[32m+[m[32m      "version": "5.3.2",[m
[32m+[m[32m      "resolved": "https://registry.npmjs.org/acorn-jsx/-/acorn-jsx-5.3.2.tgz",[m
[32m+[m[32m      "integrity": "sha512-rq9s+JNhf0IChjtDXxllJ7g41oZk5SlXtp0LHwyA5cejwn7vKmKp4pPri6YEePv2PU65sAsegbXtIinmDFDXgQ==",[m
[32m+[m[32m      "dev": true,[m
[32m+[m[32m      "license": "MIT",[m
[32m+[m[32m      "peerDependencies": {[m
[32m+[m[32m        "acorn": "^6.0.0 || ^7.0.0 || ^8.0.0"[m
[32m+[m[32m      }[m
[32m+[m[32m    },[m
[32m+[m[32m    "node_modules/ajv": {[m
[32m+[m[32m      "version": "6.12.6",[m
[32m+[m[32m      "resolved": "https://registry.npmjs.org/ajv/-/ajv-6.12.6.tgz",[m
[32m+[m[32m      "integrity": "sha512-j3fVLgvTo527anyYyJOGTYJbG+vnnQYvE0m5mmkc1TK+nxAppkCLMIL0aZ4dblVCNoGShhm+kzE4ZUykBoMg4g==",[m
[32m+[m[32m      "dev": true,[m
[32m+[m[32m      "license": "MIT",[m
[32m+[m[32m      "dependencies": {[m
[32m+[m[32m        "fast-deep-equal": "^3.1.1",[m
[32m+[m[32m        "fast-json-stable-stringify": "^2.0.0",[m
[32m+[m[32m        "json-schema-traverse": "^0.4.1",[m
[32m+[m[32m        "uri-js": "^4.2.2"[m
[32m+[m[32m      },[m
[32m+[m[32m      "funding": {[m
[32m+[m[32m        "type": "github",[m
[32m+[m[32m        "url": "https://github.com/sponsors/epoberezkin"[m
[32m+[m[32m      }[m
[32m+[m[32m    },[m
[32m+[m[32m    "node_modules/ansi-styles": {[m
[32m+[m[32m      "version": "4.3.0",[m
[32m+[m[32m      "resolved": "https://registry.npmjs.org/ansi-styles/-/ansi-styles-4.3.0.tgz",[m
[32m+[m[32m      "integrity": "sha512-zbB9rCJAT1rbjiVDb2hqKFHNYLxgtk8NURxZ3IZwD3F6NtxbXZQCnnSi1Lkx+IDohdPlFp222wVALIheZJQSEg==",[m
[32m+[m[32m      "dev": true,[m
[32m+[m[32m      "license": "MIT",[m
[32m+[m[32m      "dependencies": {[m
[32m+[m[32m        "color-convert": "^2.0.1"[m
[32m+[m[32m      },[m
[32m+[m[32m      "engines": {[m
[32m+[m[32m        "node": ">=8"[m
[32m+[m[32m      },[m
[32m+[m[32m      "funding": {[m
[32m+[m[32m        "url": "https://github.com/chalk/ansi-styles?sponsor=1"[m
[32m+[m[32m      }[m
[32m+[m[32m    },[m
[32m+[m[32m    "node_modules/argparse": {[m
[32m+[m[32m      "version": "2.0.1",[m
[32m+[m[32m      "resolved": "https://registry.npmjs.org/argparse/-/argparse-2.0.1.tgz",[m
[32m+[m[32m      "integrity": "sha512-8+9WqebbFzpX9OR+Wa6O29asIogeRMzcGtAINdpMHHyAg10f05aSFVBbcEqGf/PXw1EjAZ+q2/bEBg3DvurK3Q==",[m
[32m+[m[32m      "dev": true,[m
[32m+[m[32m      "license": "Python-2.0"[m
[32m+[m[32m    },[m
[32m+[m[32m    "node_modules/asynckit": {[m
[32m+[m[32m      "version": "0.4.0",[m
[32m+[m[32m      "resolved": "https://registry.npmjs.org/asynckit/-/asynckit-0.4.0.tgz",[m
[32m+[m[32m      "integrity": "sha512-Oei9OH4tRh0YqU3GxhX79dM/mwVgvbZJaSNaRk+bshkj0S5cfHcgYakreBjrHwatXKbz+IoIdYLxrKim2MjW0Q==",[m
[32m+[m[32m      "license": "MIT"[m
[32m+[m[32m    },[m
[32m+[m[32m    "node_modules/axios": {[m
[32m+[m[32m      "version": "1.8.4",[m
[32m+[m[32m      "resolved": "https://registry.npmjs.org/axios/-/axios-1.8.4.tgz",[m
[32m+[m[32m      "integrity": "sha512-eBSYY4Y68NNlHbHBMdeDmKNtDgXWhQsJcGqzO3iLUM0GraQFSS9cVgPX5I9b3lbdFKyYoAEGAZF1DwhTaljNAw==",[m
[32m+[m[32m      "license": "MIT",[m
[32m+[m[32m      "dependencies": {[m
[32m+[m[32m        "follow-redirects": "^1.15.6",[m
[32m+[m[32m        "form-data": "^4.0.0",[m
[32m+[m[32m        "proxy-from-env": "^1.1.0"[m
[32m+[m[32m      }[m
[32m+[m[32m    },[m
[32m+[m[32m    "node_modules/balanced-match": {[m
[32m+[m[32m      "version": "1.0.2",[m
[32m+[m[32m      "resolved": "https://registry.npmjs.org/balanced-match/-/balanced-match-1.0.2.tgz",[m
[32m+[m[32m      "integrity": "sha512-3oSeUO0TMV67hN1AmbXsK4yaqU7tjiHlbxRDZOpH0KW9+CeX4bRAaX0Anxt0tx2MrpRpWwQaPwIlISEJhYU5Pw==",[m
[32m+[m[32m      "dev": true,[m
[32m+[m[32m      "license": "MIT"[m
[32m+[m[32m    },[m
[32m+[m[32m    "node_modules/brace-expansion": {[m
[32m+[m[32m      "version": "1.1.11",[m
[32m+[m[32m      "resolved": "https://registry.npmjs.org/brace-expansion/-/brace-expansion-1.1.11.tgz",[m
[32m+[m[32m      "integrity": "sha512-iCuPHDFgrHX7H2vEI/5xpz07zSHB00TpugqhmYtVmMO6518mCuRMoOYFldEBl0g187ufozdaHgWKcYFb61qGiA==",[m
[32m+[m[32m      "dev": true,[m
[32m+[m[32m      "license": "MIT",[m
[32m+[m[32m      "dependencies": {[m
[32m+[m[32m        "balanced-match": "^1.0.0",[m
[32m+[m[32m        "concat-map": "0.0.1"[m
[32m+[m[32m      }[m
[32m+[m[32m    },[m
[32m+[m[32m    "node_modules/browserslist": {[m
[32m+[m[32m      "version": "4.24.4",[m
[32m+[m[32m      "resolved": "https://registry.npmjs.org/browserslist/-/browserslist-4.24.4.tgz",[m
[32m+[m[32m      "integrity": "sha512-KDi1Ny1gSePi1vm0q4oxSF8b4DR44GF4BbmS2YdhPLOEqd8pDviZOGH/GsmRwoWJ2+5Lr085X7naowMwKHDG1A==",[m
[32m+[m[32m      "dev": true,[m
[32m+[m[32m      "funding": [[m
[32m+[m[32m        {[m
[32m+[m[32m          "type": "opencollective",[m
[32m+[m[32m          "url": "https://opencollective.com/browserslist"[m
[32m+[m[32m        },[m
[32m+[m[32m        {[m
[32m+[m[32m          "type": "tidelift",[m
[32m+[m[32m          "url": "https://tidelift.com/funding/github/npm/browserslist"[m
[32m+[m[32m        },[m
[32m+[m[32m        {[m
[32m+[m[32m          "type": "github",[m
[32m+[m[32m          "url": "https://github.com/sponsors/ai"[m
[32m+[m[32m        }[m
[32m+[m[32m      ],[m
[32m+[m[32m      "license": "MIT",[m
[32m+[m[32m      "dependencies": {[m
[32m+[m[32m        "caniuse-lite": "^1.0.30001688",[m
[32m+[m[32m        "electron-to-chromium": "^1.5.73",[m
[32m+[m[32m        "node-releases": "^2.0.19",[m
[32m+[m[32m        "update-browserslist-db": "^1.1.1"[m
[32m+[m[32m      },[m
[32m+[m[32m      "bin": {[m
[32m+[m[32m        "browserslist": "cli.js"[m
[32m+[m[32m      },[m
[32m+[m[32m      "engines": {[m
[32m+[m[32m        "node": "^6 || ^7 || ^8 || ^9 || ^10 || ^11 || ^12 || >=13.7"[m
[32m+[m[32m      }[m
[32m+[m[32m    },[m
[32m+[m[32m    "node_modules/call-bind-apply-helpers": {[m
[32m+[m[32m      "version": "1.0.2",[m
[32m+[m[32m      "resolved": "https://registry.npmjs.org/call-bind-apply-helpers/-/call-bind-apply-helpers-1.0.2.tgz",[m
[32m+[m[32m      "integrity": "sha512-Sp1ablJ0ivDkSzjcaJdxEunN5/XvksFJ2sMBFfq6x0ryhQV/2b/KwFe21cMpmHtPOSij8K99/wSfoEuTObmuMQ==",[m
[32m+[m[32m      "license": "MIT",[m
[32m+[m[32m      "dependencies": {[m
[32m+[m[32m        "es-errors": "^1.3.0",[m
[32m+[m[32m        "function-bind": "^1.1.2"[m
[32m+[m[32m      },[m
[32m+[m[32m      "engines": {[m
[32m+[m[32m        "node": ">= 0.4"[m
[32m+[m[32m      }[m
[32m+[m[32m    },[m
[32m+[m[32m    "node_modules/callsites": {[m
[32m+[m[32m      "version": "3.1.0",[m
[32m+[m[32m      "resolved": "https://registry.npmjs.org/callsites/-/callsites-3.1.0.tgz",[m
[32m+[m[32m      "integrity": "sha512-P8BjAsXvZS+VIDUI11hHCQEv74YT67YUi5JJFNWIqL235sBmjX4+qx9Muvls5ivyNENctx46xQLQ3aTuE7ssaQ==",[m
[32m+[m[32m      "dev": true,[m
[32m+[m[32m      "license": "MIT",[m
[32m+[m[32m      "engines": {[m
[32m+[m[32m        "node": ">=6"[m
[32m+[m[32m      }[m
[32m+[m[32m    },[m
[32m+[m[32m    "node_modules/caniuse-lite": {[m
[32m+[m[32m      "version": "1.0.30001707",[m
[32m+[m[32m      "resolved": "https://registry.npmjs.org/caniuse-lite/-/caniuse-lite-1.0.30001707.tgz",[m
[32m+[m[32m      "integrity": "sha512-3qtRjw/HQSMlDWf+X79N206fepf4SOOU6SQLMaq/0KkZLmSjPxAkBOQQ+FxbHKfHmYLZFfdWsO3KA90ceHPSnw==",[m
[32m+[m[32m      "dev": true,[m
[32m+[m[32m      "funding": [[m
[32m+[m[32m        {[m
[32m+[m[32m          "type": "opencollective",[m
[32m+[m[32m          "url": "https://opencollective.com/browserslist"[m
[32m+[m[32m        },[m
[32m+[m[32m        {[m
[32m+[m[32m          "type": "tidelift",[m
[32m+[m[32m          "url": "https://tidelift.com/funding/github/npm/caniuse-lite"[m
[32m+[m[32m        },[m
[32m+[m[32m        {[m
[32m+[m[32m          "type": "github",[m
[32m+[m[32m          "url": "https://github.com/sponsors/ai"[m
[32m+[m[32m        }[m
[32m+[m[32m      ],[m
[32m+[m[32m      "license": "CC-BY-4.0"[m
[32m+[m[32m    },[m
[32m+[m[32m    "node_modules/chalk": {[m
[32m+[m[32m      "version": "4.1.2",[m
[32m+[m[32m      "resolved": "https://registry.npmjs.org/chalk/-/chalk-4.1.2.tgz",[m
[32m+[m[32m      "integrity": "sha512-oKnbhFyRIXpUuez8iBMmyEa4nbj4IOQyuhc/wy9kY7/WVPcwIO9VA668Pu8RkO7+0G76SLROeyw9CpQ061i4mA==",[m
[32m+[m[32m      "dev": true,[m
[32m+[m[32m      "license": "MIT",[m
[32m+[m[32m      "dependencies": {[m
[32m+[m[32m        "ansi-styles": "^4.1.0",[m
[32m+[m[32m        "supports-color": "^7.1.0"[m
[32m+[m[32m      },[m
[32m+[m[32m      "engines": {[m
[32m+[m[32m        "node": ">=10"[m
[32m+[m[32m      },[m
[32m+[m[32m      "funding": {[m
[32m+[m[32m        "url": "https://github.com/chalk/chalk?sponsor=1"[m
[32m+[m[32m      }[m
[32m+[m[32m    },[m
[32m+[m[32m    "node_modules/color-convert": {[m
[32m+[m[32m      "version": "2.0.1",[m
[32m+[m[32m      "resolved": "https://registry.npmjs.org/color-convert/-/color-convert-2.0.1.tgz",[m
[32m+[m[32m      "integrity": "sha512-RRECPsj7iu/xb5oKYcsFHSppFNnsj/52OVTRKb4zP5onXwVF3zVmmToNcOfGC+CRDpfK/U584fMg38ZHCaElKQ==",[m
[32m+[m[32m      "dev": true,[m
[32m+[m[32m      "license": "MIT",[m
[32m+[m[32m      "dependencies": {[m
[32m+[m[32m        "color-name": "~1.1.4"[m
[32m+[m[32m      },[m
[32m+[m[32m      "engines": {[m
[32m+[m[32m        "node": ">=7.0.0"[m
[32m+[m[32m      }[m
[32m+[m[32m    },[m
[32m+[m[32m    "node_modules/color-name": {[m
[32m+[m[32m      "version": "1.1.4",[m
[32m+[m[32m      "resolved": "https://registry.npmjs.org/color-name/-/color-name-1.1.4.tgz",[m
[32m+[m[32m      "integrity": "sha512-dOy+3AuW3a2wNbZHIuMZpTcgjGuLU/uBL/ubcZF9OXbDo8ff4O8yVp5Bf0efS8uEoYo5q4Fx7dY9OgQGXgAsQA==",[m
[32m+[m[32m      "dev": true,[m
[32m+[m[32m      "license": "MIT"[m
[32m+[m[32m    },[m
[32m+[m[32m    "node_modules/combined-stream": {[m
[32m+[m[32m      "version": "1.0.8",[m
[32m+[m[32m      "resolved": "https://registry.npmjs.org/combined-stream/-/combined-stream-1.0.8.tgz",[m
[32m+[m[32m      "integrity": "sha512-FQN4MRfuJeHf7cBbBMJFXhKSDq+2kAArBlmRBvcvFE5BB1HZKXtSFASDhdlz9zOYwxh8lDdnvmMOe/+5cdoEdg==",[m
[32m+[m[32m      "license": "MIT",[m
[32m+[m[32m      "dependencies": {[m
[32m+[m[32m        "delayed-stream": "~1.0.0"[m
[32m+[m[32m      },[m
[32m+[m[32m      "engines": {[m
[32m+[m[32m        "node": ">= 0.8"[m
[32m+[m[32m      }[m
[32m+[m[32m    },[m
[32m+[m[32m    "node_modules/concat-map": {[m
[32m+[m[32m      "version": "0.0.1",[m
[32m+[m[32m      "resolved": "https://registry.npmjs.org/concat-map/-/concat-map-0.0.1.tgz",[m
[32m+[m[32m      "integrity": "sha512-/Srv4dswyQNBfohGpz9o6Yb3Gz3SrUDqBH5rTuhGR7ahtlbYKnVxw2bCFMRljaA7EXHaXZ8wsHdodFvbkhKmqg==",[m
[32m+[m[32m      "dev": true,[m
[32m+[m[32m      "license": "MIT"[m
[32m+[m[32m    },[m
[32m+[m[32m    "node_modules/convert-source-map": {[m
[32m+[m[32m      "version": "2.0.0",[m
[32m+[m[32m      "resolved": "https://registry.npmjs.org/convert-source-map/-/convert-source-map-2.0.0.tgz",[m
[32m+[m[32m      "integrity": "sha512-Kvp459HrV2FEJ1CAsi1Ku+MY3kasH19TFykTz2xWmMeq6bk2NU3XXvfJ+Q61m0xktWwt+1HSYf3JZsTms3aRJg==",[m
[32m+[m[32m      "dev": true,[m
[32m+[m[32m      "license": "MIT"[m
[32m+[m[32m    },[m
[32m+[m[32m    "node_modules/cookie": {[m
[32m+[m[32m      "version": "1.0.2",[m
[32m+[m[32m      "resolved": "https://registry.npmjs.org/cookie/-/cookie-1.0.2.tgz",[m
[32m+[m[32m      "integrity": "sha512-9Kr/j4O16ISv8zBBhJoi4bXOYNTkFLOqSL3UDB0njXxCXNezjeyVrJyGOWtgfs/q2km1gwBcfH8q1yEGoMYunA==",[m
[32m+[m[32m      "license": "MIT",[m
[32m+[m[32m      "engines": {[m
[32m+[m[32m        "node": ">=18"[m
[32m+[m[32m      }[m
[32m+[m[32m    },[m
[32m+[m[32m    "node_modules/cross-spawn": {[m
[32m+[m[32m      "version": "7.0.6",[m
[32m+[m[32m      "resolved": "https://registry.npmjs.org/cross-spawn/-/cross-spawn-7.0.6.tgz",[m
[32m+[m[32m      "integrity": "sha512-uV2QOWP2nWzsy2aMp8aRibhi9dlzF5Hgh5SHaB9OiTGEyDTiJJyx0uy51QXdyWbtAHNua4XJzUKca3OzKUd3vA==",[m
[32m+[m[32m      "dev": true,[m
[32m+[m[32m      "license": "MIT",[m
[32m+[m[32m      "dependencies": {[m
[32m+[m[32m        "path-key": "^3.1.0",[m
[32m+[m[32m        "shebang-command": "^2.0.0",[m
[32m+[m[32m        "which": "^2.0.1"[m
[32m+[m[32m      },[m
[32m+[m[32m      "engines": {[m
[32m+[m[32m        "node": ">= 8"[m
[32m+[m[32m      }[m
[32m+[m[32m    },[m
[32m+[m[32m    "node_modules/csstype": {[m
[32m+[m[32m      "version": "3.1.3",[m
[32m+[m[32m      "resolved": "https://registry.npmjs.org/csstype/-/csstype-3.1.3.tgz",[m
[32m+[m[32m      "integrity": "sha512-M1uQkMl8rQK/szD0LNhtqxIPLpimGm8sOBwU7lLnCpSbTyY3yeU1Vc7l4KT5zT4s/yOxHH5O7tIuuLOCnLADRw==",[m
[32m+[m[32m      "dev": true,[m
[32m+[m[32m      "license": "MIT"[m
[32m+[m[32m    },[m
[32m+[m[32m    "node_modules/debug": {[m
[32m+[m[32m      "version": "4.4.0",[m
[32m+[m[32m      "resolved": "https://registry.npmjs.org/debug/-/debug-4.4.0.tgz",[m
[32m+[m[32m      "integrity": "sha512-6WTZ/IxCY/T6BALoZHaE4ctp9xm+Z5kY/pzYaCHRFeyVhojxlrm+46y68HA6hr0TcwEssoxNiDEUJQjfPZ/RYA==",[m
[32m+[m[32m      "dev": true,[m
[32m+[m[32m      "license": "MIT",[m
[32m+[m[32m      "dependencies": {[m
[32m+[m[32m        "ms": "^2.1.3"[m
[32m+[m[32m      },[m
[32m+[m[32m      "engines": {[m
[32m+[m[32m        "node": ">=6.0"[m
[32m+[m[32m      },[m
[32m+[m[32m      "peerDependenciesMeta": {[m
[32m+[m[32m        "supports-color": {[m
[32m+[m[32m          "optional": true[m
[32m+[m[32m        }[m
[32m+[m[32m      }[m
[32m+[m[32m    },[m
[32m+[m[32m    "node_modules/deep-is": {[m
[32m+[m[32m      "version": "0.1.4",[m
[32m+[m[32m      "resolved": "https://registry.npmjs.org/deep-is/-/deep-is-0.1.4.tgz",[m
[32m+[m[32m      "integrity": "sha512-oIPzksmTg4/MriiaYGO+okXDT7ztn/w3Eptv/+gSIdMdKsJo0u4CfYNFJPy+4SKMuCqGw2wxnA+URMg3t8a/bQ==",[m
[32m+[m[32m      "dev": true,[m
[32m+[m[32m      "license": "MIT"[m
[32m+[m[32m    },[m
[32m+[m[32m    "node_modules/delayed-stream": {[m
[32m+[m[32m      "version": "1.0.0",[m
[32m+[m[32m      "resolved": "https://registry.npmjs.org/delayed-stream/-/delayed-stream-1.0.0.tgz",[m
[32m+[m[32m      "integrity": "sha512-ZySD7Nf91aLB0RxL4KGrKHBXl7Eds1DAmEdcoVawXnLD7SDhpNgtuII2aAkg7a7QS41jxPSZ17p4VdGnMHk3MQ==",[m
[32m+[m[32m      "license": "MIT",[m
[32m+[m[32m      "engines": {[m
[32m+[m[32m        "node": ">=0.4.0"[m
[32m+[m[32m      }[m
[32m+[m[32m    },[m
[32m+[m[32m    "node_modules/detect-libc": {[m
[32m+[m[32m      "version": "2.0.3",[m
[32m+[m[32m      "resolved": "https://registry.npmjs.org/detect-libc/-/detect-libc-2.0.3.tgz",[m
[32m+[m[32m      "integrity": "sha512-bwy0MGW55bG41VqxxypOsdSdGqLwXPI/focwgTYCFMbdUiBAxLg9CFzG08sz2aqzknwiX7Hkl0bQENjg8iLByw==",[m
[32m+[m[32m      "license": "Apache-2.0",[m
[32m+[m[32m      "engines": {[m
[32m+[m[32m        "node": ">=8"[m
[32m+[m[32m      }[m
[32m+[m[32m    },[m
[32m+[m[32m    "node_modules/dunder-proto": {[m
[32m+[m[32m      "version": "1.0.1",[m
[32m+[m[32m      "resolved": "https://registry.npmjs.org/dunder-proto/-/dunder-proto-1.0.1.tgz",[m
[32m+[m[32m      "integrity": "sha512-KIN/nDJBQRcXw0MLVhZE9iQHmG68qAVIBg9CqmUYjmQIhgij9U5MFvrqkUL5FbtyyzZuOeOt0zdeRe4UY7ct+A==",[m
[32m+[m[32m      "license": "MIT",[m
[32m+[m[32m      "dependencies": {[m
[32m+[m[32m        "call-bind-apply-helpers": "^1.0.1",[m
[32m+[m[32m        "es-errors": "^1.3.0",[m
[32m+[m[32m        "gopd": "^1.2.0"[m
[32m+[m[32m      },[m
[32m+[m[32m      "engines": {[m
[32m+[m[32m        "node": ">= 0.4"[m
[32m+[m[32m      }[m
[32m+[m[32m    },[m
[32m+[m[32m    "node_modules/electron-to-chromium": {[m
[32m+[m[32m      "version": "1.5.123",[m
[32m+[m[32m      "resolved": "https://registry.npmjs.org/electron-to-chromium/-/electron-to-chromium-1.5.123.tgz",[m
[32m+[m[32m      "integrity": "sha512-refir3NlutEZqlKaBLK0tzlVLe5P2wDKS7UQt/3SpibizgsRAPOsqQC3ffw1nlv3ze5gjRQZYHoPymgVZkplFA==",[m
[32m+[m[32m      "dev": true,[m
[32m+[m[32m      "license": "ISC"[m
[32m+[m[32m    },[m
[32m+[m[32m    "node_modules/enhanced-resolve": {[m
[32m+[m[32m      "version": "5.18.1",[m
[32m+[m[32m      "resolved": "https://registry.npmjs.org/enhanced-resolve/-/enhanced-resolve-5.18.1.tgz",[m
[32m+[m[32m      "integrity": "sha512-ZSW3ma5GkcQBIpwZTSRAI8N71Uuwgs93IezB7mf7R60tC8ZbJideoDNKjHn2O9KIlx6rkGTTEk1xUCK2E1Y2Yg==",[m
[32m+[m[32m      "license": "MIT",[m
[32m+[m[32m      "dependencies": {[m
[32m+[m[32m        "graceful-fs": "^4.2.4",[m
[32m+[m[32m        "tapable": "^2.2.0"[m
[32m+[m[32m      },[m
[32m+[m[32m      "engines": {[m
[32m+[m[32m        "node": ">=10.13.0"[m
[32m+[m[32m      }[m
[32m+[m[32m    },[m
[32m+[m[32m    "node_modules/es-define-property": {[m
[32m+[m[32m      "version": "1.0.1",[m
[32m+[m[32m      "resolved": "https://registry.npmjs.org/es-define-property/-/es-define-property-1.0.1.tgz",[m
[32m+[m[32m      "integrity": "sha512-e3nRfgfUZ4rNGL232gUgX06QNyyez04KdjFrF+LTRoOXmrOgFKDg4BCdsjW8EnT69eqdYGmRpJwiPVYNrCaW3g==",[m
[32m+[m[32m      "license": "MIT",[m
[32m+[m[32m      "engines": {[m
[32m+[m[32m        "node": ">= 0.4"[m
[32m+[m[32m      }[m
[32m+[m[32m    },[m
[32m+[m[32m    "node_modules/es-errors": {[m
[32m+[m[32m      "version": "1.3.0",[m
[32m+[m[32m      "resolved": "https://registry.npmjs.org/es-errors/-/es-errors-1.3.0.tgz",[m
[32m+[m[32m      "integrity": "sha512-Zf5H2Kxt2xjTvbJvP2ZWLEICxA6j+hAmMzIlypy4xcBg1vKVnx89Wy0GbS+kf5cwCVFFzdCFh2XSCFNULS6csw==",[m
[32m+[m[32m      "license": "MIT",[m
[32m+[m[32m      "engines": {[m
[32m+[m[32m        "node": ">= 0.4"[m
[32m+[m[32m      }[m
[32m+[m[32m    },[m
[32m+[m[32m    "node_modules/es-object-atoms": {[m
[32m+[m[32m      "version": "1.1.1",[m
[32m+[m[32m      "resolved": "https://registry.npmjs.org/es-object-atoms/-/es-object-atoms-1.1.1.tgz",[m
[32m+[m[32m      "integrity": "sha512-FGgH2h8zKNim9ljj7dankFPcICIK9Cp5bm+c2gQSYePhpaG5+esrLODihIorn+Pe6FGJzWhXQotPv73jTaldXA==",[m
[32m+[m[32m      "license": "MIT",[m
[32m+[m[32m      "dependencies": {[m
[32m+[m[32m        "es-errors": "^1.3.0"[m
[32m+[m[32m      },[m
[32m+[m[32m      "engines": {[m
[32m+[m[32m        "node": ">= 0.4"[m
[32m+[m[32m      }[m
[32m+[m[32m    },[m
[32m+[m[32m    "node_modules/es-set-tostringtag": {[m
[32m+[m[32m      "version": "2.1.0",[m
[32m+[m[32m      "resolved": "https://registry.npmjs.org/es-set-tostringtag/-/es-set-tostringtag-2.1.0.tgz",[m
[32m+[m[32m      "integrity": "sha512-j6vWzfrGVfyXxge+O0x5sh6cvxAog0a/4Rdd2K36zCMV5eJ+/+tOAngRO8cODMNWbVRdVlmGZQL2YS3yR8bIUA==",[m
[32m+[m[32m      "license": "MIT",[m
[32m+[m[32m      "dependencies": {[m
[32m+[m[32m        "es-errors": "^1.3.0",[m
[32m+[m[32m        "get-intrinsic": "^1.2.6",[m
[32m+[m[32m        "has-tostringtag": "^1.0.2",[m
[32m+[m[32m        "hasown": "^2.0.2"[m
[32m+[m[32m      },[m
[32m+[m[32m      "engines": {[m
[32m+[m[32m        "node": ">= 0.4"[m
[32m+[m[32m      }[m
[32m+[m[32m    },[m
[32m+[m[32m    "node_modules/esbuild": {[m
[32m+[m[32m      "version": "0.25.1",[m
[32m+[m[32m      "resolved": "https://registry.npmjs.org/esbuild/-/esbuild-0.25.1.tgz",[m
[32m+[m[32m      "integrity": "sha512-BGO5LtrGC7vxnqucAe/rmvKdJllfGaYWdyABvyMoXQlfYMb2bbRuReWR5tEGE//4LcNJj9XrkovTqNYRFZHAMQ==",[m
[32m+[m[32m      "hasInstallScript": true,[m
[32m+[m[32m      "license": "MIT",[m
[32m+[m[32m      "bin": {[m
[32m+[m[32m        "esbuild": "bin/esbuild"[m
[32m+[m[32m      },[m
[32m+[m[32m      "engines": {[m
[32m+[m[32m        "node": ">=18"[m
[32m+[m[32m      },[m
[32m+[m[32m      "optionalDependencies": {[m
[32m+[m[32m        "@esbuild/aix-ppc64": "0.25.1",[m
[32m+[m[32m        "@esbuild/android-arm": "0.25.1",[m
[32m+[m[32m        "@esbuild/android-arm64": "0.25.1",[m
[32m+[m[32m        "@esbuild/android-x64": "0.25.1",[m
[32m+[m[32m        "@esbuild/darwin-arm64": "0.25.1",[m
[32m+[m[32m        "@esbuild/darwin-x64": "0.25.1",[m
[32m+[m[32m        "@esbuild/freebsd-arm64": "0.25.1",[m
[32m+[m[32m        "@esbuild/freebsd-x64": "0.25.1",[m
[32m+[m[32m        "@esbuild/linux-arm": "0.25.1",[m
[32m+[m[32m        "@esbuild/linux-arm64": "0.25.1",[m
[32m+[m[32m        "@esbuild/linux-ia32": "0.25.1",[m
[32m+[m[32m        "@esbuild/linux-loong64": "0.25.1",[m
[32m+[m[32m        "@esbuild/linux-mips64el": "0.25.1",[m
[32m+[m[32m        "@esbuild/linux-ppc64": "0.25.1",[m
[32m+[m[32m        "@esbuild/linux-riscv64": "0.25.1",[m
[32m+[m[32m        "@esbuild/linux-s390x": "0.25.1",[m
[32m+[m[32m        "@esbuild/linux-x64": "0.25.1",[m
[32m+[m[32m        "@esbuild/netbsd-arm64": "0.25.1",[m
[32m+[m[32m        "@esbuild/netbsd-x64": "0.25.1",[m
[32m+[m[32m        "@esbuild/openbsd-arm64": "0.25.1",[m
[32m+[m[32m        "@esbuild/openbsd-x64": "0.25.1",[m
[32m+[m[32m        "@esbuild/sunos-x64": "0.25.1",[m
[32m+[m[32m        "@esbuild/win32-arm64": "0.25.1",[m
[32m+[m[32m        "@esbuild/win32-ia32": "0.25.1",[m
[32m+[m[32m        "@esbuild/win32-x64": "0.25.1"[m
[32m+[m[32m      }[m
[32m+[m[32m    },[m
[32m+[m[32m    "node_modules/escalade": {[m
[32m+[m[32m      "version": "3.2.0",[m
[32m+[m[32m      "resolved": "https://registry.npmjs.org/escalade/-/escalade-3.2.0.tgz",[m
[32m+[m[32m      "integrity": "sha512-WUj2qlxaQtO4g6Pq5c29GTcWGDyd8itL8zTlipgECz3JesAiiOKotd8JU6otB3PACgG6xkJUyVhboMS+bje/jA==",[m
[32m+[m[32m      "dev": true,[m
[32m+[m[32m      "license": "MIT",[m
[32m+[m[32m      "engines": {[m
[32m+[m[32m        "node": ">=6"[m
[32m+[m[32m      }[m
[32m+[m[32m    },[m
[32m+[m[32m    "node_modules/escape-string-regexp": {[m
[32m+[m[32m      "version": "4.0.0",[m
[32m+[m[32m      "resolved": "https://registry.npmjs.org/escape-string-regexp/-/escape-string-regexp-4.0.0.tgz",[m
[32m+[m[32m      "integrity": "sha512-TtpcNJ3XAzx3Gq8sWRzJaVajRs0uVxA2YAkdb1jm2YkPz4G6egUFAyA3n5vtEIZefPk5Wa4UXbKuS5fKkJWdgA==",[m
[32m+[m[32m      "dev": true,[m
[32m+[m[32m      "license": "MIT",[m
[32m+[m[32m      "engines": {[m
[32m+[m[32m        "node": ">=10"[m
[32m+[m[32m      },[m
[32m+[m[32m      "funding": {[m
[32m+[m[32m        "url": "https://github.com/sponsors/sindresorhus"[m
[32m+[m[32m      }[m
[32m+[m[32m    },[m
[32m+[m[32m    "node_modules/eslint": {[m
[32m+[m[32m      "version": "9.23.0",[m
[32m+[m[32m      "resolved": "https://registry.npmjs.org/eslint/-/eslint-9.23.0.tgz",[m
[32m+[m[32m      "integrity": "sha512-jV7AbNoFPAY1EkFYpLq5bslU9NLNO8xnEeQXwErNibVryjk67wHVmddTBilc5srIttJDBrB0eMHKZBFbSIABCw==",[m
[32m+[m[32m      "dev": true,[m
[32m+[m[32m      "license": "MIT",[m
[32m+[m[32m      "dependencies": {[m
[32m+[m[32m        "@eslint-community/eslint-utils": "^4.2.0",[m
[32m+[m[32m        "@eslint-community/regexpp": "^4.12.1",[m
[32m+[m[32m        "@eslint/config-array": "^0.19.2",[m
[32m+[m[32m        "@eslint/config-helpers": "^0.2.0",[m
[32m+[m[32m        "@eslint/core": "^0.12.0",[m
[32m+[m[32m        "@eslint/eslintrc": "^3.3.1",[m
[32m+[m[32m        "@eslint/js": "9.23.0",[m
[32m+[m[32m        "@eslint/plugin-kit": "^0.2.7",[m
[32m+[m[32m        "@humanfs/node": "^0.16.6",[m
[32m+[m[32m        "@humanwhocodes/module-importer": "^1.0.1",[m
[32m+[m[32m        "@humanwhocodes/retry": "^0.4.2",[m
[32m+[m[32m        "@types/estree": "^1.0.6",[m
[32m+[m[32m        "@types/json-schema": "^7.0.15",[m
[32m+[m[32m        "ajv": "^6.12.4",[m
[32m+[m[32m        "chalk": "^4.0.0",[m
[32m+[m[32m        "cross-spawn": "^7.0.6",[m
[32m+[m[32m        "debug": "^4.3.2",[m
[32m+[m[32m        "escape-string-regexp": "^4.0.0",[m
[32m+[m[32m        "eslint-scope": "^8.3.0",[m
[32m+[m[32m        "eslint-visitor-keys": "^4.2.0",[m
[32m+[m[32m        "espree": "^10.3.0",[m
[32m+[m[32m        "esquery": "^1.5.0",[m
[32m+[m[32m        "esutils": "^2.0.2",[m
[32m+[m[32m        "fast-deep-equal": "^3.1.3",[m
[32m+[m[32m        "file-entry-cache": "^8.0.0",[m
[32m+[m[32m        "find-up": "^5.0.0",[m
[32m+[m[32m        "glob-parent": "^6.0.2",[m
[32m+[m[32m        "ignore": "^5.2.0",[m
[32m+[m[32m        "imurmurhash": "^0.1.4",[m
[32m+[m[32m        "is-glob": "^4.0.0",[m
[32m+[m[32m        "json-stable-stringify-without-jsonify": "^1.0.1",[m
[32m+[m[32m        "lodash.merge": "^4.6.2",[m
[32m+[m[32m        "minimatch": "^3.1.2",[m
[32m+[m[32m        "natural-compare": "^1.4.0",[m
[32m+[m[32m        "optionator": "^0.9.3"[m
[32m+[m[32m      },[m
[32m+[m[32m      "bin": {[m
[32m+[m[32m        "eslint": "bin/eslint.js"[m
[32m+[m[32m      },[m
[32m+[m[32m      "engines": {[m
[32m+[m[32m        "node": "^18.18.0 || ^20.9.0 || >=21.1.0"[m
[32m+[m[32m      },[m
[32m+[m[32m      "funding": {[m
[32m+[m[32m        "url": "https://eslint.org/donate"[m
[32m+[m[32m      },[m
[32m+[m[32m      "peerDependencies": {[m
[32m+[m[32m        "jiti": "*"[m
[32m+[m[32m      },[m
[32m+[m[32m      "peerDependenciesMeta": {[m
[32m+[m[32m        "jiti": {[m
[32m+[m[32m          "optional": true[m
[32m+[m[32m        }[m
[32m+[m[32m      }[m
[32m+[m[32m    },[m
[32m+[m[32m    "node_modules/eslint-plugin-react-hooks": {[m
[32m+[m[32m      "version": "5.2.0",[m
[32m+[m[32m      "resolved": "https://registry.npmjs.org/eslint-plugin-react-hooks/-/eslint-plugin-react-hooks-5.2.0.tgz",[m
[32m+[m[32m      "integrity": "sha512-+f15FfK64YQwZdJNELETdn5ibXEUQmW1DZL6KXhNnc2heoy/sg9VJJeT7n8TlMWouzWqSWavFkIhHyIbIAEapg==",[m
[32m+[m[32m      "dev": true,[m
[32m+[m[32m      "license": "MIT",[m
[32m+[m[32m      "engines": {[m
[32m+[m[32m        "node": ">=10"[m
[32m+[m[32m      },[m
[32m+[m[32m      "peerDependencies": {[m
[32m+[m[32m        "eslint": "^3.0.0 || ^4.0.0 || ^5.0.0 || ^6.0.0 || ^7.0.0 || ^8.0.0-0 || ^9.0.0"[m
[32m+[m[32m      }[m
[32m+[m[32m    },[m
[32m+[m[32m    "node_modules/eslint-plugin-react-refresh": {[m
[32m+[m[32m      "version": "0.4.19",[m
[32m+[m[32m      "resolved": "https://registry.npmjs.org/eslint-plugin-react-refresh/-/eslint-plugin-react-refresh-0.4.19.tgz",[m
[32m+[m[32m      "integrity": "sha512-eyy8pcr/YxSYjBoqIFSrlbn9i/xvxUFa8CjzAYo9cFjgGXqq1hyjihcpZvxRLalpaWmueWR81xn7vuKmAFijDQ==",[m
[32m+[m[32m      "dev": true,[m
[32m+[m[32m      "license": "MIT",[m
[32m+[m[32m      "peerDependencies": {[m
[32m+[m[32m        "eslint": ">=8.40"[m
[32m+[m[32m      }[m
[32m+[m[32m    },[m
[32m+[m[32m    "node_modules/eslint-scope": {[m
[32m+[m[32m      "version": "8.3.0",[m
[32m+[m[32m      "resolved": "https://registry.npmjs.org/eslint-scope/-/eslint-scope-8.3.0.tgz",[m
[32m+[m[32m      "integrity": "sha512-pUNxi75F8MJ/GdeKtVLSbYg4ZI34J6C0C7sbL4YOp2exGwen7ZsuBqKzUhXd0qMQ362yET3z+uPwKeg/0C2XCQ==",[m
[32m+[m[32m      "dev": true,[m
[32m+[m[32m      "license": "BSD-2-Clause",[m
[32m+[m[32m      "dependencies": {[m
[32m+[m[32m        "esrecurse": "^4.3.0",[m
[32m+[m[32m        "estraverse": "^5.2.0"[m
[32m+[m[32m      },[m
[32m+[m[32m      "engines": {[m
[32m+[m[32m        "node": "^18.18.0 || ^20.9.0 || >=21.1.0"[m
[32m+[m[32m      },[m
[32m+[m[32m      "funding": {[m
[32m+[m[32m        "url": "https://opencollective.com/eslint"[m
[32m+[m[32m      }[m
[32m+[m[32m    },[m
[32m+[m[32m    "node_modules/eslint-visitor-keys": {[m
[32m+[m[32m      "version": "4.2.0",[m
[32m+[m[32m      "resolved": "https://registry.npmjs.org/eslint-visitor-keys/-/eslint-visitor-keys-4.2.0.tgz",[m
[32m+[m[32m      "integrity": "sha512-UyLnSehNt62FFhSwjZlHmeokpRK59rcz29j+F1/aDgbkbRTk7wIc9XzdoasMUbRNKDM0qQt/+BJ4BrpFeABemw==",[m
[32m+[m[32m      "dev": true,[m
[32m+[m[32m      "license": "Apache-2.0",[m
[32m+[m[32m      "engines": {[m
[32m+[m[32m        "node": "^18.18.0 || ^20.9.0 || >=21.1.0"[m
[32m+[m[32m      },[m
[32m+[m[32m      "funding": {[m
[32m+[m[32m        "url": "https://opencollective.com/eslint"[m
[32m+[m[32m      }[m
[32m+[m[32m    },[m
[32m+[m[32m    "node_modules/espree": {[m
[32m+[m[32m      "version": "10.3.0",[m
[32m+[m[32m      "resolved": "https://registry.npmjs.org/espree/-/espree-10.3.0.tgz",[m
[32m+[m[32m      "integrity": "sha512-0QYC8b24HWY8zjRnDTL6RiHfDbAWn63qb4LMj1Z4b076A4une81+z03Kg7l7mn/48PUTqoLptSXez8oknU8Clg==",[m
[32m+[m[32m      "dev": true,[m
[32m+[m[32m      "license": "BSD-2-Clause",[m
[32m+[m[32m      "dependencies": {[m
[32m+[m[32m        "acorn": "^8.14.0",[m
[32m+[m[32m        "acorn-jsx": "^5.3.2",[m
[32m+[m[32m        "eslint-visitor-keys": "^4.2.0"[m
[32m+[m[32m      },[m
[32m+[m[32m      "engines": {[m
[32m+[m[32m        "node": "^18.18.0 || ^20.9.0 || >=21.1.0"[m
[32m+[m[32m      },[m
[32m+[m[32m      "funding": {[m
[32m+[m[32m        "url": "https://opencollective.com/eslint"[m
[32m+[m[32m      }[m
[32m+[m[32m    },[m
[32m+[m[32m    "node_modules/esquery": {[m
[32m+[m[32m      "version": "1.6.0",[m
[32m+[m[32m      "resolved": "https://registry.npmjs.org/esquery/-/esquery-1.6.0.tgz",[m
[32m+[m[32m      "integrity": "sha512-ca9pw9fomFcKPvFLXhBKUK90ZvGibiGOvRJNbjljY7s7uq/5YO4BOzcYtJqExdx99rF6aAcnRxHmcUHcz6sQsg==",[m
[32m+[m[32m      "dev": true,[m
[32m+[m[32m      "license": "BSD-3-Clause",[m
[32m+[m[32m      "dependencies": {[m
[32m+[m[32m        "estraverse": "^5.1.0"[m
[32m+[m[32m      },[m
[32m+[m[32m      "engines": {[m
[32m+[m[32m        "node": ">=0.10"[m
[32m+[m[32m      }[m
[32m+[m[32m    },[m
[32m+[m[32m    "node_modules/esrecurse": {[m
[32m+[m[32m      "version": "4.3.0",[m
[32m+[m[32m      "resolved": "https://registry.npmjs.org/esrecurse/-/esrecurse-4.3.0.tgz",[m
[32m+[m[32m      "integrity": "sha512-KmfKL3b6G+RXvP8N1vr3Tq1kL/oCFgn2NYXEtqP8/L3pKapUA4G8cFVaoF3SU323CD4XypR/ffioHmkti6/Tag==",[m
[32m+[m[32m      "dev": true,[m
[32m+[m[32m      "license": "BSD-2-Clause",[m
[32m+[m[32m      "dependencies": {[m
[32m+[m[32m        "estraverse": "^5.2.0"[m
[32m+[m[32m      },[m
[32m+[m[32m      "engines": {[m
[32m+[m[32m        "node": ">=4.0"[m
[32m+[m[32m      }[m
[32m+[m[32m    },[m
[32m+[m[32m    "node_modules/estraverse": {[m
[32m+[m[32m      "version": "5.3.0",[m
[32m+[m[32m      "resolved": "https://registry.npmjs.org/estraverse/-/estraverse-5.3.0.tgz",[m
[32m+[m[32m      "integrity": "sha512-MMdARuVEQziNTeJD8DgMqmhwR11BRQ/cBP+pLtYdSTnf3MIO8fFeiINEbX36ZdNlfU/7A9f3gUw49B3oQsvwBA==",[m
[32m+[m[32m      "dev": true,[m
[32m+[m[32m      "license": "BSD-2-Clause",[m
[32m+[m[32m      "engines": {[m
[32m+[m[32m        "node": ">=4.0"[m
[32m+[m[32m      }[m
[32m+[m[32m    },[m
[32m+[m[32m    "node_modules/esutils": {[m
[32m+[m[32m      "version": "2.0.3",[m
[32m+[m[32m      "resolved": "https://registry.npmjs.org/esutils/-/esutils-2.0.3.tgz",[m
[32m+[m[32m      "integrity": "sha512-kVscqXk4OCp68SZ0dkgEKVi6/8ij300KBWTJq32P/dYeWTSwK41WyTxalN1eRmA5Z9UU/LX9D7FWSmV9SAYx6g==",[m
[32m+[m[32m      "dev": true,[m
[32m+[m[32m      "license": "BSD-2-Clause",[m
[32m+[m[32m      "engines": {[m
[32m+[m[32m        "node": ">=0.10.0"[m
[32m+[m[32m      }[m
[32m+[m[32m    },[m
[32m+[m[32m    "node_modules/fast-deep-equal": {[m
[32m+[m[32m      "version": "3.1.3",[m
[32m+[m[32m      "resolved": "https://registry.npmjs.org/fast-deep-equal/-/fast-deep-equal-3.1.3.tgz",[m
[32m+[m[32m      "integrity": "sha512-f3qQ9oQy9j2AhBe/H9VC91wLmKBCCU/gDOnKNAYG5hswO7BLKj09Hc5HYNz9cGI++xlpDCIgDaitVs03ATR84Q==",[m
[32m+[m[32m      "dev": true,[m
[32m+[m[32m      "license": "MIT"[m
[32m+[m[32m    },[m
[32m+[m[32m    "node_modules/fast-json-stable-stringify": {[m
[32m+[m[32m      "version": "2.1.0",[m
[32m+[m[32m      "resolved": "https://registry.npmjs.org/fast-json-stable-stringify/-/fast-json-stable-stringify-2.1.0.tgz",[m
[32m+[m[32m      "integrity": "sha512-lhd/wF+Lk98HZoTCtlVraHtfh5XYijIjalXck7saUtuanSDyLMxnHhSXEDJqHxD7msR8D0uCmqlkwjCV8xvwHw==",[m
[32m+[m[32m      "dev": true,[m
[32m+[m[32m      "license": "MIT"[m
[32m+[m[32m    },[m
[32m+[m[32m    "node_modules/fast-levenshtein": {[m
[32m+[m[32m      "version": "2.0.6",[m
[32m+[m[32m      "resolved": "https://registry.npmjs.org/fast-levenshtein/-/fast-levenshtein-2.0.6.tgz",[m
[32m+[m[32m      "integrity": "sha512-DCXu6Ifhqcks7TZKY3Hxp3y6qphY5SJZmrWMDrKcERSOXWQdMhU9Ig/PYrzyw/ul9jOIyh0N4M0tbC5hodg8dw==",[m
[32m+[m[32m      "dev": true,[m
[32m+[m[32m      "license": "MIT"[m
[32m+[m[32m    },[m
[32m+[m[32m    "node_modules/file-entry-cache": {[m
[32m+[m[32m      "version": "8.0.0",[m
[32m+[m[32m      "resolved": "https://registry.npmjs.org/file-entry-cache/-/file-entry-cache-8.0.0.tgz",[m
[32m+[m[32m      "integrity": "sha512-XXTUwCvisa5oacNGRP9SfNtYBNAMi+RPwBFmblZEF7N7swHYQS6/Zfk7SRwx4D5j3CH211YNRco1DEMNVfZCnQ==",[m
[32m+[m[32m      "dev": true,[m
[32m+[m[32m      "license": "MIT",[m
[32m+[m[32m      "dependencies": {[m
[32m+[m[32m        "flat-cache": "^4.0.0"[m
[32m+[m[32m      },[m
[32m+[m[32m      "engines": {[m
[32m+[m[32m        "node": ">=16.0.0"[m
[32m+[m[32m      }[m
[32m+[m[32m    },[m
[32m+[m[32m    "node_modules/find-up": {[m
[32m+[m[32m      "version": "5.0.0",[m
[32m+[m[32m      "resolved": "https://registry.npmjs.org/find-up/-/find-up-5.0.0.tgz",[m
[32m+[m[32m      "integrity": "sha512-78/PXT1wlLLDgTzDs7sjq9hzz0vXD+zn+7wypEe4fXQxCmdmqfGsEPQxmiCSQI3ajFV91bVSsvNtrJRiW6nGng==",[m
[32m+[m[32m      "dev": true,[m
[32m+[m[32m      "license": "MIT",[m
[32m+[m[32m      "dependencies": {[m
[32m+[m[32m        "locate-path": "^6.0.0",[m
[32m+[m[32m        "path-exists": "^4.0.0"[m
[32m+[m[32m      },[m
[32m+[m[32m      "engines": {[m
[32m+[m[32m        "node": ">=10"[m
[32m+[m[32m      },[m
[32m+[m[32m      "funding": {[m
[32m+[m[32m        "url": "https://github.com/sponsors/sindresorhus"[m
[32m+[m[32m      }[m
[32m+[m[32m    },[m
[32m+[m[32m    "node_modules/flat-cache": {[m
[32m+[m[32m      "version": "4.0.1",[m
[32m+[m[32m      "resolved": "https://registry.npmjs.org/flat-cache/-/flat-cache-4.0.1.tgz",[m
[32m+[m[32m      "integrity": "sha512-f7ccFPK3SXFHpx15UIGyRJ/FJQctuKZ0zVuN3frBo4HnK3cay9VEW0R6yPYFHC0AgqhukPzKjq22t5DmAyqGyw==",[m
[32m+[m[32m      "dev": true,[m
[32m+[m[32m      "license": "MIT",[m
[32m+[m[32m      "dependencies": {[m
[32m+[m[32m        "flatted": "^3.2.9",[m
[32m+[m[32m        "keyv": "^4.5.4"[m
[32m+[m[32m      },[m
[32m+[m[32m      "engines": {[m
[32m+[m[32m        "node": ">=16"[m
[32m+[m[32m      }[m
[32m+[m[32m    },[m
[32m+[m[32m    "node_modules/flatted": {[m
[32m+[m[32m      "version": "3.3.3",[m
[32m+[m[32m      "resolved": "https://registry.npmjs.org/flatted/-/flatted-3.3.3.tgz",[m
[32m+[m[32m      "integrity": "sha512-GX+ysw4PBCz0PzosHDepZGANEuFCMLrnRTiEy9McGjmkCQYwRq4A/X786G/fjM/+OjsWSU1ZrY5qyARZmO/uwg==",[m
[32m+[m[32m      "dev": true,[m
[32m+[m[32m      "license": "ISC"[m
[32m+[m[32m    },[m
[32m+[m[32m    "node_modules/follow-redirects": {[m
[32m+[m[32m      "version": "1.15.9",[m
[32m+[m[32m      "resolved": "https://registry.npmjs.org/follow-redirects/-/follow-redirects-1.15.9.tgz",[m
[32m+[m[32m      "integrity": "sha512-gew4GsXizNgdoRyqmyfMHyAmXsZDk6mHkSxZFCzW9gwlbtOW44CDtYavM+y+72qD/Vq2l550kMF52DT8fOLJqQ==",[m
[32m+[m[32m      "funding": [[m
[32m+[m[32m        {[m
[32m+[m[32m          "type": "individual",[m
[32m+[m[32m          "url": "https://github.com/sponsors/RubenVerborgh"[m
[32m+[m[32m        }[m
[32m+[m[32m      ],[m
[32m+[m[32m      "license": "MIT",[m
[32m+[m[32m      "engines": {[m
[32m+[m[32m        "node": ">=4.0"[m
[32m+[m[32m      },[m
[32m+[m[32m      "peerDependenciesMeta": {[m
[32m+[m[32m        "debug": {[m
[32m+[m[32m          "optional": true[m
[32m+[m[32m        }[m
[32m+[m[32m      }[m
[32m+[m[32m    },[m
[32m+[m[32m    "node_modules/form-data": {[m
[32m+[m[32m      "version": "4.0.2",[m
[32m+[m[32m      "resolved": "https://registry.npmjs.org/form-data/-/form-data-4.0.2.tgz",[m
[32m+[m[32m      "integrity": "sha512-hGfm/slu0ZabnNt4oaRZ6uREyfCj6P4fT/n6A1rGV+Z0VdGXjfOhVUpkn6qVQONHGIFwmveGXyDs75+nr6FM8w==",[m
[32m+[m[32m      "license": "MIT",[m
[32m+[m[32m      "dependencies": {[m
[32m+[m[32m        "asynckit": "^0.4.0",[m
[32m+[m[32m        "combined-stream": "^1.0.8",[m
[32m+[m[32m        "es-set-tostringtag": "^2.1.0",[m
[32m+[m[32m        "mime-types": "^2.1.12"[m
[32m+[m[32m      },[m
[32m+[m[32m      "engines": {[m
[32m+[m[32m        "node": ">= 6"[m
[32m+[m[32m      }[m
[32m+[m[32m    },[m
[32m+[m[32m    "node_modules/fsevents": {[m
[32m+[m[32m      "version": "2.3.3",[m
[32m+[m[32m      "resolved": "https://registry.npmjs.org/fsevents/-/fsevents-2.3.3.tgz",[m
[32m+[m[32m      "integrity": "sha512-5xoDfX+fL7faATnagmWPpbFtwh/R77WmMMqqHGS65C3vvB0YHrgF+B1YmZ3441tMj5n63k0212XNoJwzlhffQw==",[m
[32m+[m[32m      "hasInstallScript": true,[m
[32m+[m[32m      "license": "MIT",[m
[32m+[m[32m      "optional": true,[m
[32m+[m[32m      "os": [[m
[32m+[m[32m        "darwin"[m
[32m+[m[32m      ],[m
[32m+[m[32m      "engines": {[m
[32m+[m[32m        "node": "^8.16.0 || ^10.6.0 || >=11.0.0"[m
[32m+[m[32m      }[m
[32m+[m[32m    },[m
[32m+[m[32m    "node_modules/function-bind": {[m
[32m+[m[32m      "version": "1.1.2",[m
[32m+[m[32m      "resolved": "https://registry.npmjs.org/function-bind/-/function-bind-1.1.2.tgz",[m
[32m+[m[32m      "integrity": "sha512-7XHNxH7qX9xG5mIwxkhumTox/MIRNcOgDrxWsMt2pAr23WHp6MrRlN7FBSFpCpr+oVO0F744iUgR82nJMfG2SA==",[m
[32m+[m[32m      "license": "MIT",[m
[32m+[m[32m      "funding": {[m
[32m+[m[32m        "url": "https://github.com/sponsors/ljharb"[m
[32m+[m[32m      }[m
[32m+[m[32m    },[m
[32m+[m[32m    "node_modules/gensync": {[m
[32m+[m[32m      "version": "1.0.0-beta.2",[m
[32m+[m[32m      "resolved": "https://registry.npmjs.org/gensync/-/gensync-1.0.0-beta.2.tgz",[m
[32m+[m[32m      "integrity": "sha512-3hN7NaskYvMDLQY55gnW3NQ+mesEAepTqlg+VEbj7zzqEMBVNhzcGYYeqFo/TlYz6eQiFcp1HcsCZO+nGgS8zg==",[m
[32m+[m[32m      "dev": true,[m
[32m+[m[32m      "license": "MIT",[m
[32m+[m[32m      "engines": {[m
[32m+[m[32m        "node": ">=6.9.0"[m
[32m+[m[32m      }[m
[32m+[m[32m    },[m
[32m+[m[32m    "node_modules/get-intrinsic": {[m
[32m+[m[32m      "version": "1.3.0",[m
[32m+[m[32m      "resolved": "https://registry.npmjs.org/get-intrinsic/-/get-intrinsic-1.3.0.tgz",[m
[32m+[m[32m      "integrity": "sha512-9fSjSaos/fRIVIp+xSJlE6lfwhES7LNtKaCBIamHsjr2na1BiABJPo0mOjjz8GJDURarmCPGqaiVg5mfjb98CQ==",[m
[32m+[m[32m      "license": "MIT",[m
[32m+[m[32m      "dependencies": {[m
[32m+[m[32m        "call-bind-apply-helpers": "^1.0.2",[m
[32m+[m[32m        "es-define-property": "^1.0.1",[m
[32m+[m[32m        "es-errors": "^1.3.0",[m
[32m+[m[32m        "es-object-atoms": "^1.1.1",[m
[32m+[m[32m        "function-bind": "^1.1.2",[m
[32m+[m[32m        "get-proto": "^1.0.1",[m
[32m+[m[32m        "gopd": "^1.2.0",[m
[32m+[m[32m        "has-symbols": "^1.1.0",[m
[32m+[m[32m        "hasown": "^2.0.2",[m
[32m+[m[32m        "math-intrinsics": "^1.1.0"[m
[32m+[m[32m      },[m
[32m+[m[32m      "engines": {[m
[32m+[m[32m        "node": ">= 0.4"[m
[32m+[m[32m      },[m
[32m+[m[32m      "funding": {[m
[32m+[m[32m        "url": "https://github.com/sponsors/ljharb"[m
[32m+[m[32m      }[m
[32m+[m[32m    },[m
[32m+[m[32m    "node_modules/get-proto": {[m
[32m+[m[32m      "version": "1.0.1",[m
[32m+[m[32m      "resolved": "https://registry.npmjs.org/get-proto/-/get-proto-1.0.1.tgz",[m
[32m+[m[32m      "integrity": "sha512-sTSfBjoXBp89JvIKIefqw7U2CCebsc74kiY6awiGogKtoSGbgjYE/G/+l9sF3MWFPNc9IcoOC4ODfKHfxFmp0g==",[m
[32m+[m[32m      "license": "MIT",[m
[32m+[m[32m      "dependencies": {[m
[32m+[m[32m        "dunder-proto": "^1.0.1",[m
[32m+[m[32m        "es-object-atoms": "^1.0.0"[m
[32m+[m[32m      },[m
[32m+[m[32m      "engines": {[m
[32m+[m[32m        "node": ">= 0.4"[m
[32m+[m[32m      }[m
[32m+[m[32m    },[m
[32m+[m[32m    "node_modules/glob-parent": {[m
[32m+[m[32m      "version": "6.0.2",[m
[32m+[m[32m      "resolved": "https://registry.npmjs.org/glob-parent/-/glob-parent-6.0.2.tgz",[m
[32m+[m[32m      "integrity": "sha512-XxwI8EOhVQgWp6iDL+3b0r86f4d6AX6zSU55HfB4ydCEuXLXc5FcYeOu+nnGftS4TEju/11rt4KJPTMgbfmv4A==",[m
[32m+[m[32m      "dev": true,[m
[32m+[m[32m      "license": "ISC",[m
[32m+[m[32m      "dependencies": {[m
[32m+[m[32m        "is-glob": "^4.0.3"[m
[32m+[m[32m      },[m
[32m+[m[32m      "engines": {[m
[32m+[m[32m        "node": ">=10.13.0"[m
[32m+[m[32m      }[m
[32m+[m[32m    },[m
[32m+[m[32m    "node_modules/globals": {[m
[32m+[m[32m      "version": "15.15.0",[m
[32m+[m[32m      "resolved": "https://registry.npmjs.org/globals/-/globals-15.15.0.tgz",[m
[32m+[m[32m      "integrity": "sha512-7ACyT3wmyp3I61S4fG682L0VA2RGD9otkqGJIwNUMF1SWUombIIk+af1unuDYgMm082aHYwD+mzJvv9Iu8dsgg==",[m
[32m+[m[32m      "dev": true,[m
[32m+[m[32m      "license": "MIT",[m
[32m+[m[32m      "engines": {[m
[32m+[m[32m        "node": ">=18"[m
[32m+[m[32m      },[m
[32m+[m[32m      "funding": {[m
[32m+[m[32m        "url": "https://github.com/sponsors/sindresorhus"[m
[32m+[m[32m      }[m
[32m+[m[32m    },[m
[32m+[m[32m    "node_modules/gopd": {[m
[32m+[m[32m      "version": "1.2.0",[m
[32m+[m[32m      "resolved": "https://registry.npmjs.org/gopd/-/gopd-1.2.0.tgz",[m
[32m+[m[32m      "integrity": "sha512-ZUKRh6/kUFoAiTAtTYPZJ3hw9wNxx+BIBOijnlG9PnrJsCcSjs1wyyD6vJpaYtgnzDrKYRSqf3OO6Rfa93xsRg==",[m
[32m+[m[32m      "license": "MIT",[m
[32m+[m[32m      "engines": {[m
[32m+[m[32m        "node": ">= 0.4"[m
[32m+[m[32m      },[m
[32m+[m[32m      "funding": {[m
[32m+[m[32m        "url": "https://github.com/sponsors/ljharb"[m
[32m+[m[32m      }[m
[32m+[m[32m    },[m
[32m+[m[32m    "node_modules/graceful-fs": {[m
[32m+[m[32m      "version": "4.2.11",[m
[32m+[m[32m      "resolved": "https://registry.npmjs.org/graceful-fs/-/graceful-fs-4.2.11.tgz",[m
[32m+[m[32m      "integrity": "sha512-RbJ5/jmFcNNCcDV5o9eTnBLJ/HszWV0P73bc+Ff4nS/rJj+YaS6IGyiOL0VoBYX+l1Wrl3k63h/KrH+nhJ0XvQ==",[m
[32m+[m[32m      "license": "ISC"[m
[32m+[m[32m    },[m
[32m+[m[32m    "node_modules/has-flag": {[m
[32m+[m[32m      "version": "4.0.0",[m
[32m+[m[32m      "resolved": "https://registry.npmjs.org/has-flag/-/has-flag-4.0.0.tgz",[m
[32m+[m[32m      "integrity": "sha512-EykJT/Q1KjTWctppgIAgfSO0tKVuZUjhgMr17kqTumMl6Afv3EISleU7qZUzoXDFTAHTDC4NOoG/ZxU3EvlMPQ==",[m
[32m+[m[32m      "dev": true,[m
[32m+[m[32m      "license": "MIT",[m
[32m+[m[32m      "engines": {[m
[32m+[m[32m        "node": ">=8"[m
[32m+[m[32m      }[m
[32m+[m[32m    },[m
[32m+[m[32m    "node_modules/has-symbols": {[m
[32m+[m[32m      "version": "1.1.0",[m
[32m+[m[32m      "resolved": "https://registry.npmjs.org/has-symbols/-/has-symbols-1.1.0.tgz",[m
[32m+[m[32m      "integrity": "sha512-1cDNdwJ2Jaohmb3sg4OmKaMBwuC48sYni5HUw2DvsC8LjGTLK9h+eb1X6RyuOHe4hT0ULCW68iomhjUoKUqlPQ==",[m
[32m+[m[32m      "license": "MIT",[m
[32m+[m[32m      "engines": {[m
[32m+[m[32m        "node": ">= 0.4"[m
[32m+[m[32m      },[m
[32m+[m[32m      "funding": {[m
[32m+[m[32m        "url": "https://github.com/sponsors/ljharb"[m
[32m+[m[32m      }[m
[32m+[m[32m    },[m
[32m+[m[32m    "node_modules/has-tostringtag": {[m
[32m+[m[32m      "version": "1.0.2",[m
[32m+[m[32m      "resolved": "https://registry.npmjs.org/has-tostringtag/-/has-tostringtag-1.0.2.tgz",[m
[32m+[m[32m      "integrity": "sha512-NqADB8VjPFLM2V0VvHUewwwsw0ZWBaIdgo+ieHtK3hasLz4qeCRjYcqfB6AQrBggRKppKF8L52/VqdVsO47Dlw==",[m
[32m+[m[32m      "license": "MIT",[m
[32m+[m[32m      "dependencies": {[m
[32m+[m[32m        "has-symbols": "^1.0.3"[m
[32m+[m[32m      },[m
[32m+[m[32m      "engines": {[m
[32m+[m[32m        "node": ">= 0.4"[m
[32m+[m[32m      },[m
[32m+[m[32m      "funding": {[m
[32m+[m[32m        "url": "https://github.com/sponsors/ljharb"[m
[32m+[m[32m      }[m
[32m+[m[32m    },[m
[32m+[m[32m    "node_modules/hasown": {[m
[32m+[m[32m      "version": "2.0.2",[m
[32m+[m[32m      "resolved": "https://registry.npmjs.org/hasown/-/hasown-2.0.2.tgz",[m
[32m+[m[32m      "integrity": "sha512-0hJU9SCPvmMzIBdZFqNPXWa6dqh7WdH0cII9y+CyS8rG3nL48Bclra9HmKhVVUHyPWNH5Y7xDwAB7bfgSjkUMQ==",[m
[32m+[m[32m      "license": "MIT",[m
[32m+[m[32m      "dependencies": {[m
[32m+[m[32m        "function-bind": "^1.1.2"[m
[32m+[m[32m      },[m
[32m+[m[32m      "engines": {[m
[32m+[m[32m        "node": ">= 0.4"[m
[32m+[m[32m      }[m
[32m+[m[32m    },[m
[32m+[m[32m    "node_modules/ignore": {[m
[32m+[m[32m      "version": "5.3.2",[m
[32m+[m[32m      "resolved": "https://registry.npmjs.org/ignore/-/ignore-5.3.2.tgz",[m
[32m+[m[32m      "integrity": "sha512-hsBTNUqQTDwkWtcdYI2i06Y/nUBEsNEDJKjWdigLvegy8kDuJAS8uRlpkkcQpyEXL0Z/pjDy5HBmMjRCJ2gq+g==",[m
[32m+[m[32m      "dev": true,[m
[32m+[m[32m      "license": "MIT",[m
[32m+[m[32m      "engines": {[m
[32m+[m[32m        "node": ">= 4"[m
[32m+[m[32m      }[m
[32m+[m[32m    },[m
[32m+[m[32m    "node_modules/import-fresh": {[m
[32m+[m[32m      "version": "3.3.1",[m
[32m+[m[32m      "resolved": "https://registry.npmjs.org/import-fresh/-/import-fresh-3.3.1.tgz",[m
[32m+[m[32m      "integrity": "sha512-TR3KfrTZTYLPB6jUjfx6MF9WcWrHL9su5TObK4ZkYgBdWKPOFoSoQIdEuTuR82pmtxH2spWG9h6etwfr1pLBqQ==",[m
[32m+[m[32m      "dev": true,[m
[32m+[m[32m      "license": "MIT",[m
[32m+[m[32m      "dependencies": {[m
[32m+[m[32m        "parent-module": "^1.0.0",[m
[32m+[m[32m        "resolve-from": "^4.0.0"[m
[32m+[m[32m      },[m
[32m+[m[32m      "engines": {[m
[32m+[m[32m        "node": ">=6"[m
[32m+[m[32m      },[m
[32m+[m[32m      "funding": {[m
[32m+[m[32m        "url": "https://github.com/sponsors/sindresorhus"[m
[32m+[m[32m      }[m
[32m+[m[32m    },[m
[32m+[m[32m    "node_modules/imurmurhash": {[m
[32m+[m[32m      "version": "0.1.4",[m
[32m+[m[32m      "resolved": "https://registry.npmjs.org/imurmurhash/-/imurmurhash-0.1.4.tgz",[m
[32m+[m[32m      "integrity": "sha512-JmXMZ6wuvDmLiHEml9ykzqO6lwFbof0GG4IkcGaENdCRDDmMVnny7s5HsIgHCbaq0w2MyPhDqkhTUgS2LU2PHA==",[m
[32m+[m[32m      "dev": true,[m
[32m+[m[32m      "license": "MIT",[m
[32m+[m[32m      "engines": {[m
[32m+[m[32m        "node": ">=0.8.19"[m
[32m+[m[32m      }[m
[32m+[m[32m    },[m
[32m+[m[32m    "node_modules/is-extglob": {[m
[32m+[m[32m      "version": "2.1.1",[m
[32m+[m[32m      "resolved": "https://registry.npmjs.org/is-extglob/-/is-extglob-2.1.1.tgz",[m
[32m+[m[32m      "integrity": "sha512-SbKbANkN603Vi4jEZv49LeVJMn4yGwsbzZworEoyEiutsN3nJYdbO36zfhGJ6QEDpOZIFkDtnq5JRxmvl3jsoQ==",[m
[32m+[m[32m      "dev": true,[m
[32m+[m[32m      "license": "MIT",[m
[32m+[m[32m      "engines": {[m
[32m+[m[32m        "node": ">=0.10.0"[m
[32m+[m[32m      }[m
[32m+[m[32m    },[m
[32m+[m[32m    "node_modules/is-glob": {[m
[32m+[m[32m      "version": "4.0.3",[m
[32m+[m[32m      "resolved": "https://registry.npmjs.org/is-glob/-/is-glob-4.0.3.tgz",[m
[32m+[m[32m      "integrity": "sha512-xelSayHH36ZgE7ZWhli7pW34hNbNl8Ojv5KVmkJD4hBdD3th8Tfk9vYasLM+mXWOZhFkgZfxhLSnrwRr4elSSg==",[m
[32m+[m[32m      "dev": true,[m
[32m+[m[32m      "license": "MIT",[m
[32m+[m[32m      "dependencies": {[m
[32m+[m[32m        "is-extglob": "^2.1.1"[m
[32m+[m[32m      },[m
[32m+[m[32m      "engines": {[m
[32m+[m[32m        "node": ">=0.10.0"[m
[32m+[m[32m      }[m
[32m+[m[32m    },[m
[32m+[m[32m    "node_modules/isexe": {[m
[32m+[m[32m      "version": "2.0.0",[m
[32m+[m[32m      "resolved": "https://registry.npmjs.org/isexe/-/isexe-2.0.0.tgz",[m
[32m+[m[32m      "integrity": "sha512-RHxMLp9lnKHGHRng9QFhRCMbYAcVpn69smSGcq3f36xjgVVWThj4qqLbTLlq7Ssj8B+fIQ1EuCEGI2lKsyQeIw==",[m
[32m+[m[32m      "dev": true,[m
[32m+[m[32m      "license": "ISC"[m
[32m+[m[32m    },[m
[32m+[m[32m    "node_modules/jiti": {[m
[32m+[m[32m      "version": "2.4.2",[m
[32m+[m[32m      "resolved": "https://registry.npmjs.org/jiti/-/jiti-2.4.2.tgz",[m
[32m+[m[32m      "integrity": "sha512-rg9zJN+G4n2nfJl5MW3BMygZX56zKPNVEYYqq7adpmMh4Jn2QNEwhvQlFy6jPVdcod7txZtKHWnyZiA3a0zP7A==",[m
[32m+[m[32m      "license": "MIT",[m
[32m+[m[32m      "bin": {[m
[32m+[m[32m        "jiti": "lib/jiti-cli.mjs"[m
[32m+[m[32m      }[m
[32m+[m[32m    },[m
[32m+[m[32m    "node_modules/js-tokens": {[m
[32m+[m[32m      "version": "4.0.0",[m
[32m+[m[32m      "resolved": "https://registry.npmjs.org/js-tokens/-/js-tokens-4.0.0.tgz",[m
[32m+[m[32m      "integrity": "sha512-RdJUflcE3cUzKiMqQgsCu06FPu9UdIJO0beYbPhHN4k6apgJtifcoCtT9bcxOpYBtpD2kCM6Sbzg4CausW/PKQ==",[m
[32m+[m[32m      "dev": true,[m
[32m+[m[32m      "license": "MIT"[m
[32m+[m[32m    },[m
[32m+[m[32m    "node_modules/js-yaml": {[m
[32m+[m[32m      "version": "4.1.0",[m
[32m+[m[32m      "resolved": "https://registry.npmjs.org/js-yaml/-/js-yaml-4.1.0.tgz",[m
[32m+[m[32m      "integrity": "sha512-wpxZs9NoxZaJESJGIZTyDEaYpl0FKSA+FB9aJiyemKhMwkxQg63h4T1KJgUGHpTqPDNRcmmYLugrRjJlBtWvRA==",[m
[32m+[m[32m      "dev": true,[m
[32m+[m[32m      "license": "MIT",[m
[32m+[m[32m      "dependencies": {[m
[32m+[m[32m        "argparse": "^2.0.1"[m
[32m+[m[32m      },[m
[32m+[m[32m      "bin": {[m
[32m+[m[32m        "js-yaml": "bin/js-yaml.js"[m
[32m+[m[32m      }[m
[32m+[m[32m    },[m
[32m+[m[32m    "node_modules/jsesc": {[m
[32m+[m[32m      "version": "3.1.0",[m
[32m+[m[32m      "resolved": "https://registry.npmjs.org/jsesc/-/jsesc-3.1.0.tgz",[m
[32m+[m[32m      "integrity": "sha512-/sM3dO2FOzXjKQhJuo0Q173wf2KOo8t4I8vHy6lF9poUp7bKT0/NHE8fPX23PwfhnykfqnC2xRxOnVw5XuGIaA==",[m
[32m+[m[32m      "dev": true,[m
[32m+[m[32m      "license": "MIT",[m
[32m+[m[32m      "bin": {[m
[32m+[m[32m        "jsesc": "bin/jsesc"[m
[32m+[m[32m      },[m
[32m+[m[32m      "engines": {[m
[32m+[m[32m        "node": ">=6"[m
[32m+[m[32m      }[m
[32m+[m[32m    },[m
[32m+[m[32m    "node_modules/json-buffer": {[m
[32m+[m[32m      "version": "3.0.1",[m
[32m+[m[32m      "resolved": "https://registry.npmjs.org/json-buffer/-/json-buffer-3.0.1.tgz",[m
[32m+[m[32m      "integrity": "sha512-4bV5BfR2mqfQTJm+V5tPPdf+ZpuhiIvTuAB5g8kcrXOZpTT/QwwVRWBywX1ozr6lEuPdbHxwaJlm9G6mI2sfSQ==",[m
[32m+[m[32m      "dev": true,[m
[32m+[m[32m      "license": "MIT"[m
[32m+[m[32m    },[m
[32m+[m[32m    "node_modules/json-schema-traverse": {[m
[32m+[m[32m      "version": "0.4.1",[m
[32m+[m[32m      "resolved": "https://registry.npmjs.org/json-schema-traverse/-/json-schema-traverse-0.4.1.tgz",[m
[32m+[m[32m      "integrity": "sha512-xbbCH5dCYU5T8LcEhhuh7HJ88HXuW3qsI3Y0zOZFKfZEHcpWiHU/Jxzk629Brsab/mMiHQti9wMP+845RPe3Vg==",[m
[32m+[m[32m      "dev": true,[m
[32m+[m[32m      "license": "MIT"[m
[32m+[m[32m    },[m
[32m+[m[32m    "node_modules/json-stable-stringify-without-jsonify": {[m
[32m+[m[32m      "version": "1.0.1",[m
[32m+[m[32m      "resolved": "https://registry.npmjs.org/json-stable-stringify-without-jsonify/-/json-stable-stringify-without-jsonify-1.0.1.tgz",[m
[32m+[m[32m      "integrity": "sha512-Bdboy+l7tA3OGW6FjyFHWkP5LuByj1Tk33Ljyq0axyzdk9//JSi2u3fP1QSmd1KNwq6VOKYGlAu87CisVir6Pw==",[m
[32m+[m[32m      "dev": true,[m
[32m+[m[32m      "license": "MIT"[m
[32m+[m[32m    },[m
[32m+[m[32m    "node_modules/json5": {[m
[32m+[m[32m      "version": "2.2.3",[m
[32m+[m[32m      "resolved": "https://registry.npmjs.org/json5/-/json5-2.2.3.tgz",[m
[32m+[m[32m      "integrity": "sha512-XmOWe7eyHYH14cLdVPoyg+GOH3rYX++KpzrylJwSW98t3Nk+U8XOl8FWKOgwtzdb8lXGf6zYwDUzeHMWfxasyg==",[m
[32m+[m[32m      "dev": true,[m
[32m+[m[32m      "license": "MIT",[m
[32m+[m[32m      "bin": {[m
[32m+[m[32m        "json5": "lib/cli.js"[m
[32m+[m[32m      },[m
[32m+[m[32m      "engines": {[m
[32m+[m[32m        "node": ">=6"[m
[32m+[m[32m      }[m
[32m+[m[32m    },[m
[32m+[m[32m    "node_modules/keyv": {[m
[32m+[m[32m      "version": "4.5.4",[m
[32m+[m[32m      "resolved": "https://registry.npmjs.org/keyv/-/keyv-4.5.4.tgz",[m
[32m+[m[32m      "integrity": "sha512-oxVHkHR/EJf2CNXnWxRLW6mg7JyCCUcG0DtEGmL2ctUo1PNTin1PUil+r/+4r5MpVgC/fn1kjsx7mjSujKqIpw==",[m
[32m+[m[32m      "dev": true,[m
[32m+[m[32m      "license": "MIT",[m
[32m+[m[32m      "dependencies": {[m
[32m+[m[32m        "json-buffer": "3.0.1"[m
[32m+[m[32m      }[m
[32m+[m[32m    },[m
[32m+[m[32m    "node_modules/levn": {[m
[32m+[m[32m      "version": "0.4.1",[m
[32m+[m[32m      "resolved": "https://registry.npmjs.org/levn/-/levn-0.4.1.tgz",[m
[32m+[m[32m      "integrity": "sha512-+bT2uH4E5LGE7h/n3evcS/sQlJXCpIp6ym8OWJ5eV6+67Dsql/LaaT7qJBAt2rzfoa/5QBGBhxDix1dMt2kQKQ==",[m
[32m+[m[32m      "dev": true,[m
[32m+[m[32m      "license": "MIT",[m
[32m+[m[32m      "dependencies": {[m
[32m+[m[32m        "prelude-ls": "^1.2.1",[m
[32m+[m[32m        "type-check": "~0.4.0"[m
[32m+[m[32m      },[m
[32m+[m[32m      "engines": {[m
[32m+[m[32m        "node": ">= 0.8.0"[m
[32m+[m[32m      }[m
[32m+[m[32m    },[m
[32m+[m[32m    "node_modules/lightningcss": {[m
[32m+[m[32m      "version": "1.29.2",[m
[32m+[m[32m      "resolved": "https://registry.npmjs.org/lightningcss/-/lightningcss-1.29.2.tgz",[m
[32m+[m[32m      "integrity": "sha512-6b6gd/RUXKaw5keVdSEtqFVdzWnU5jMxTUjA2bVcMNPLwSQ08Sv/UodBVtETLCn7k4S1Ibxwh7k68IwLZPgKaA==",[m
[32m+[m[32m      "license": "MPL-2.0",[m
[32m+[m[32m      "dependencies": {[m
[32m+[m[32m        "detect-libc": "^2.0.3"[m
[32m+[m[32m      },[m
[32m+[m[32m      "engines": {[m
[32m+[m[32m        "node": ">= 12.0.0"[m
[32m+[m[32m      },[m
[32m+[m[32m      "funding": {[m
[32m+[m[32m        "type": "opencollective",[m
[32m+[m[32m        "url": "https://opencollective.com/parcel"[m
[32m+[m[32m      },[m
[32m+[m[32m      "optionalDependencies": {[m
[32m+[m[32m        "lightningcss-darwin-arm64": "1.29.2",[m
[32m+[m[32m        "lightningcss-darwin-x64": "1.29.2",[m
[32m+[m[32m        "lightningcss-freebsd-x64": "1.29.2",[m
[32m+[m[32m        "lightningcss-linux-arm-gnueabihf": "1.29.2",[m
[32m+[m[32m        "lightningcss-linux-arm64-gnu": "1.29.2",[m
[32m+[m[32m        "lightningcss-linux-arm64-musl": "1.29.2",[m
[32m+[m[32m        "lightningcss-linux-x64-gnu": "1.29.2",[m
[32m+[m[32m        "lightningcss-linux-x64-musl": "1.29.2",[m
[32m+[m[32m        "lightningcss-win32-arm64-msvc": "1.29.2",[m
[32m+[m[32m        "lightningcss-win32-x64-msvc": "1.29.2"[m
[32m+[m[32m      }[m
[32m+[m[32m    },[m
[32m+[m[32m    "node_modules/lightningcss-darwin-arm64": {[m
[32m+[m[32m      "version": "1.29.2",[m
[32m+[m[32m      "resolved": "https://registry.npmjs.org/lightningcss-darwin-arm64/-/lightningcss-darwin-arm64-1.29.2.tgz",[m
[32m+[m[32m      "integrity": "sha512-cK/eMabSViKn/PG8U/a7aCorpeKLMlK0bQeNHmdb7qUnBkNPnL+oV5DjJUo0kqWsJUapZsM4jCfYItbqBDvlcA==",[m
[32m+[m[32m      "cpu": [[m
[32m+[m[32m        "arm64"[m
[32m+[m[32m      ],[m
[32m+[m[32m      "license": "MPL-2.0",[m
[32m+[m[32m      "optional": true,[m
[32m+[m[32m      "os": [[m
[32m+[m[32m        "darwin"[m
[32m+[m[32m      ],[m
[32m+[m[32m      "engines": {[m
[32m+[m[32m        "node": ">= 12.0.0"[m
[32m+[m[32m      },[m
[32m+[m[32m      "funding": {[m
[32m+[m[32m        "type": "opencollective",[m
[32m+[m[32m        "url": "https://opencollective.com/parcel"[m
[32m+[m[32m      }[m
[32m+[m[32m    },[m
[32m+[m[32m    "node_modules/lightningcss-darwin-x64": {[m
[32m+[m[32m      "version": "1.29.2",[m
[32m+[m[32m      "resolved": "https://registry.npmjs.org/lightningcss-darwin-x64/-/lightningcss-darwin-x64-1.29.2.tgz",[m
[32m+[m[32m      "integrity": "sha512-j5qYxamyQw4kDXX5hnnCKMf3mLlHvG44f24Qyi2965/Ycz829MYqjrVg2H8BidybHBp9kom4D7DR5VqCKDXS0w==",[m
[32m+[m[32m      "cpu": [[m
[32m+[m[32m        "x64"[m
[32m+[m[32m      ],[m
[32m+[m[32m      "license": "MPL-2.0",[m
[32m+[m[32m      "optional": true,[m
[32m+[m[32m      "os": [[m
[32m+[m[32m        "darwin"[m
[32m+[m[32m      ],[m
[32m+[m[32m      "engines": {[m
[32m+[m[32m        "node": ">= 12.0.0"[m
[32m+[m[32m      },[m
[32m+[m[32m      "funding": {[m
[32m+[m[32m        "type": "opencollective",[m
[32m+[m[32m        "url": "https://opencollective.com/parcel"[m
[32m+[m[32m      }[m
[32m+[m[32m    },[m
[32m+[m[32m    "node_modules/lightningcss-freebsd-x64": {[m
[32m+[m[32m      "version": "1.29.2",[m
[32m+[m[32m      "resolved": "https://registry.npmjs.org/lightningcss-freebsd-x64/-/lightningcss-freebsd-x64-1.29.2.tgz",[m
[32m+[m[32m      "integrity": "sha512-wDk7M2tM78Ii8ek9YjnY8MjV5f5JN2qNVO+/0BAGZRvXKtQrBC4/cn4ssQIpKIPP44YXw6gFdpUF+Ps+RGsCwg==",[m
[32m+[m[32m      "cpu": [[m
[32m+[m[32m        "x64"[m
[32m+[m[32m      ],[m
[32m+[m[32m      "license": "MPL-2.0",[m
[32m+[m[32m      "optional": true,[m
[32m+[m[32m      "os": [[m
[32m+[m[32m        "freebsd"[m
[32m+[m[32m      ],[m
[32m+[m[32m      "engines": {[m
[32m+[m[32m        "node": ">= 12.0.0"[m
[32m+[m[32m      },[m
[32m+[m[32m      "funding": {[m
[32m+[m[32m        "type": "opencollective",[m
[32m+[m[32m        "url": "https://opencollective.com/parcel"[m
[32m+[m[32m      }[m
[32m+[m[32m    },[m
[32m+[m[32m    "node_modules/lightningcss-linux-arm-gnueabihf": {[m
[32m+[m[32m      "version": "1.29.2",[m
[32m+[m[32m      "resolved": "https://registry.npmjs.org/lightningcss-linux-arm-gnueabihf/-/lightningcss-linux-arm-gnueabihf-1.29.2.tgz",[m
[32m+[m[32m      "integrity": "sha512-IRUrOrAF2Z+KExdExe3Rz7NSTuuJ2HvCGlMKoquK5pjvo2JY4Rybr+NrKnq0U0hZnx5AnGsuFHjGnNT14w26sg==",[m
[32m+[m[32m      "cpu": [[m
[32m+[m[32m        "arm"[m
[32m+[m[32m      ],[m
[32m+[m[32m      "license": "MPL-2.0",[m
[32m+[m[32m      "optional": true,[m
[32m+[m[32m      "os": [[m
[32m+[m[32m        "linux"[m
[32m+[m[32m      ],[m
[32m+[m[32m      "engines": {[m
[32m+[m[32m        "node": ">= 12.0.0"[m
[32m+[m[32m      },[m
[32m+[m[32m      "funding": {[m
[32m+[m[32m        "type": "opencollective",[m
[32m+[m[32m        "url": "https://opencollective.com/parcel"[m
[32m+[m[32m      }[m
[32m+[m[32m    },[m
[32m+[m[32m    "node_modules/lightningcss-linux-arm64-gnu": {[m
[32m+[m[32m      "version": "1.29.2",[m
[32m+[m[32m      "resolved": "https://registry.npmjs.org/lightningcss-linux-arm64-gnu/-/lightningcss-linux-arm64-gnu-1.29.2.tgz",[m
[32m+[m[32m      "integrity": "sha512-KKCpOlmhdjvUTX/mBuaKemp0oeDIBBLFiU5Fnqxh1/DZ4JPZi4evEH7TKoSBFOSOV3J7iEmmBaw/8dpiUvRKlQ==",[m
[32m+[m[32m      "cpu": [[m
[32m+[m[32m        "arm64"[m
[32m+[m[32m      ],[m
[32m+[m[32m      "license": "MPL-2.0",[m
[32m+[m[32m      "optional": true,[m
[32m+[m[32m      "os": [[m
[32m+[m[32m        "linux"[m
[32m+[m[32m      ],[m
[32m+[m[32m      "engines": {[m
[32m+[m[32m        "node": ">= 12.0.0"[m
[32m+[m[32m      },[m
[32m+[m[32m      "funding": {[m
[32m+[m[32m        "type": "opencollective",[m
[32m+[m[32m        "url": "https://opencollective.com/parcel"[m
[32m+[m[32m      }[m
[32m+[m[32m    },[m
[32m+[m[32m    "node_modules/lightningcss-linux-arm64-musl": {[m
[32m+[m[32m      "version": "1.29.2",[m
[32m+[m[32m      "resolved": "https://registry.npmjs.org/lightningcss-linux-arm64-musl/-/lightningcss-linux-arm64-musl-1.29.2.tgz",[m
[32m+[m[32m      "integrity": "sha512-Q64eM1bPlOOUgxFmoPUefqzY1yV3ctFPE6d/Vt7WzLW4rKTv7MyYNky+FWxRpLkNASTnKQUaiMJ87zNODIrrKQ==",[m
[32m+[m[32m      "cpu": [[m
[32m+[m[32m        "arm64"[m
[32m+[m[32m      ],[m
[32m+[m[32m      "license": "MPL-2.0",[m
[32m+[m[32m      "optional": true,[m
[32m+[m[32m      "os": [[m
[32m+[m[32m        "linux"[m
[32m+[m[32m      ],[m
[32m+[m[32m      "engines": {[m
[32m+[m[32m        "node": ">= 12.0.0"[m
[32m+[m[32m      },[m
[32m+[m[32m      "funding": {[m
[32m+[m[32m        "type": "opencollective",[m
[32m+[m[32m        "url": "https://opencollective.com/parcel"[m
[32m+[m[32m      }[m
[32m+[m[32m    },[m
[32m+[m[32m    "node_modules/lightningcss-linux-x64-gnu": {[m
[32m+[m[32m      "version": "1.29.2",[m
[32m+[m[32m      "resolved": "https://registry.npmjs.org/lightningcss-linux-x64-gnu/-/lightningcss-linux-x64-gnu-1.29.2.tgz",[m
[32m+[m[32m      "integrity": "sha512-0v6idDCPG6epLXtBH/RPkHvYx74CVziHo6TMYga8O2EiQApnUPZsbR9nFNrg2cgBzk1AYqEd95TlrsL7nYABQg==",[m
[32m+[m[32m      "cpu": [[m
[32m+[m[32m        "x64"[m
[32m+[m[32m      ],[m
[32m+[m[32m      "license": "MPL-2.0",[m
[32m+[m[32m      "optional": true,[m
[32m+[m[32m      "os": [[m
[32m+[m[32m        "linux"[m
[32m+[m[32m      ],[m
[32m+[m[32m      "engines": {[m
[32m+[m[32m        "node": ">= 12.0.0"[m
[32m+[m[32m      },[m
[32m+[m[32m      "funding": {[m
[32m+[m[32m        "type": "opencollective",[m
[32m+[m[32m        "url": "https://opencollective.com/parcel"[m
[32m+[m[32m      }[m
[32m+[m[32m    },[m
[32m+[m[32m    "node_modules/lightningcss-linux-x64-musl": {[m
[32m+[m[32m      "version": "1.29.2",[m
[32m+[m[32m      "resolved": "https://registry.npmjs.org/lightningcss-linux-x64-musl/-/lightningcss-linux-x64-musl-1.29.2.tgz",[m
[32m+[m[32m      "integrity": "sha512-rMpz2yawkgGT8RULc5S4WiZopVMOFWjiItBT7aSfDX4NQav6M44rhn5hjtkKzB+wMTRlLLqxkeYEtQ3dd9696w==",[m
[32m+[m[32m      "cpu": [[m
[32m+[m[32m        "x64"[m
[32m+[m[32m      ],[m
[32m+[m[32m      "license": "MPL-2.0",[m
[32m+[m[32m      "optional": true,[m
[32m+[m[32m      "os": [[m
[32m+[m[32m        "linux"[m
[32m+[m[32m      ],[m
[32m+[m[32m      "engines": {[m
[32m+[m[32m        "node": ">= 12.0.0"[m
[32m+[m[32m      },[m
[32m+[m[32m      "funding": {[m
[32m+[m[32m        "type": "opencollective",[m
[32m+[m[32m        "url": "https://opencollective.com/parcel"[m
[32m+[m[32m      }[m
[32m+[m[32m    },[m
[32m+[m[32m    "node_modules/lightningcss-win32-arm64-msvc": {[m
[32m+[m[32m      "version": "1.29.2",[m
[32m+[m[32m      "resolved": "https://registry.npmjs.org/lightningcss-win32-arm64-msvc/-/lightningcss-win32-arm64-msvc-1.29.2.tgz",[m
[32m+[m[32m      "integrity": "sha512-nL7zRW6evGQqYVu/bKGK+zShyz8OVzsCotFgc7judbt6wnB2KbiKKJwBE4SGoDBQ1O94RjW4asrCjQL4i8Fhbw==",[m
[32m+[m[32m      "cpu": [[m
[32m+[m[32m        "arm64"[m
[32m+[m[32m      ],[m
[32m+[m[32m      "license": "MPL-2.0",[m
[32m+[m[32m      "optional": true,[m
[32m+[m[32m      "os": [[m
[32m+[m[32m        "win32"[m
[32m+[m[32m      ],[m
[32m+[m[32m      "engines": {[m
[32m+[m[32m        "node": ">= 12.0.0"[m
[32m+[m[32m      },[m
[32m+[m[32m      "funding": {[m
[32m+[m[32m        "type": "opencollective",[m
[32m+[m[32m        "url": "https://opencollective.com/parcel"[m
[32m+[m[32m      }[m
[32m+[m[32m    },[m
[32m+[m[32m    "node_modules/lightningcss-win32-x64-msvc": {[m
[32m+[m[32m      "version": "1.29.2",[m
[32m+[m[32m      "resolved": "https://registry.npmjs.org/lightningcss-win32-x64-msvc/-/lightningcss-win32-x64-msvc-1.29.2.tgz",[m
[32m+[m[32m      "integrity": "sha512-EdIUW3B2vLuHmv7urfzMI/h2fmlnOQBk1xlsDxkN1tCWKjNFjfLhGxYk8C8mzpSfr+A6jFFIi8fU6LbQGsRWjA==",[m
[32m+[m[32m      "cpu": [[m
[32m+[m[32m        "x64"[m
[32m+[m[32m      ],[m
[32m+[m[32m      "license": "MPL-2.0",[m
[32m+[m[32m      "optional": true,[m
[32m+[m[32m      "os": [[m
[32m+[m[32m        "win32"[m
[32m+[m[32m      ],[m
[32m+[m[32m      "engines": {[m
[32m+[m[32m        "node": ">= 12.0.0"[m
[32m+[m[32m      },[m
[32m+[m[32m      "funding": {[m
[32m+[m[32m        "type": "opencollective",[m
[32m+[m[32m        "url": "https://opencollective.com/parcel"[m
[32m+[m[32m      }[m
[32m+[m[32m    },[m
[32m+[m[32m    "node_modules/locate-path": {[m
[32m+[m[32m      "version": "6.0.0",[m
[32m+[m[32m      "resolved": "https://registry.npmjs.org/locate-path/-/locate-path-6.0.0.tgz",[m
[32m+[m[32m      "integrity": "sha512-iPZK6eYjbxRu3uB4/WZ3EsEIMJFMqAoopl3R+zuq0UjcAm/MO6KCweDgPfP3elTztoKP3KtnVHxTn2NHBSDVUw==",[m
[32m+[m[32m      "dev": true,[m
[32m+[m[32m      "license": "MIT",[m
[32m+[m[32m      "dependencies": {[m
[32m+[m[32m        "p-locate": "^5.0.0"[m
[32m+[m[32m      },[m
[32m+[m[32m      "engines": {[m
[32m+[m[32m        "node": ">=10"[m
[32m+[m[32m      },[m
[32m+[m[32m      "funding": {[m
[32m+[m[32m        "url": "https://github.com/sponsors/sindresorhus"[m
[32m+[m[32m      }[m
[32m+[m[32m    },[m
[32m+[m[32m    "node_modules/lodash.merge": {[m
[32m+[m[32m      "version": "4.6.2",[m
[32m+[m[32m      "resolved": "https://registry.npmjs.org/lodash.merge/-/lodash.merge-4.6.2.tgz",[m
[32m+[m[32m      "integrity": "sha512-0KpjqXRVvrYyCsX1swR/XTK0va6VQkQM6MNo7PqW77ByjAhoARA8EfrP1N4+KlKj8YS0ZUCtRT/YUuhyYDujIQ==",[m
[32m+[m[32m      "dev": true,[m
[32m+[m[32m      "license": "MIT"[m
[32m+[m[32m    },[m
[32m+[m[32m    "node_modules/lru-cache": {[m
[32m+[m[32m      "version": "5.1.1",[m
[32m+[m[32m      "resolved": "https://registry.npmjs.org/lru-cache/-/lru-cache-5.1.1.tgz",[m
[32m+[m[32m      "integrity": "sha512-KpNARQA3Iwv+jTA0utUVVbrh+Jlrr1Fv0e56GGzAFOXN7dk/FviaDW8LHmK52DlcH4WP2n6gI8vN1aesBFgo9w==",[m
[32m+[m[32m      "dev": true,[m
[32m+[m[32m      "license": "ISC",[m
[32m+[m[32m      "dependencies": {[m
[32m+[m[32m        "yallist": "^3.0.2"[m
[32m+[m[32m      }[m
[32m+[m[32m    },[m
[32m+[m[32m    "node_modules/math-intrinsics": {[m
[32m+[m[32m      "version": "1.1.0",[m
[32m+[m[32m      "resolved": "https://registry.npmjs.org/math-intrinsics/-/math-intrinsics-1.1.0.tgz",[m
[32m+[m[32m      "integrity": "sha512-/IXtbwEk5HTPyEwyKX6hGkYXxM9nbj64B+ilVJnC/R6B0pH5G4V3b0pVbL7DBj4tkhBAppbQUlf6F6Xl9LHu1g==",[m
[32m+[m[32m      "license": "MIT",[m
[32m+[m[32m      "engines": {[m
[32m+[m[32m        "node": ">= 0.4"[m
[32m+[m[32m      }[m
[32m+[m[32m    },[m
[32m+[m[32m    "node_modules/mime-db": {[m
[32m+[m[32m      "version": "1.52.0",[m
[32m+[m[32m      "resolved": "https://registry.npmjs.org/mime-db/-/mime-db-1.52.0.tgz",[m
[32m+[m[32m      "integrity": "sha512-sPU4uV7dYlvtWJxwwxHD0PuihVNiE7TyAbQ5SWxDCB9mUYvOgroQOwYQQOKPJ8CIbE+1ETVlOoK1UC2nU3gYvg==",[m
[32m+[m[32m      "license": "MIT",[m
[32m+[m[32m      "engines": {[m
[32m+[m[32m        "node": ">= 0.6"[m
[32m+[m[32m      }[m
[32m+[m[32m    },[m
[32m+[m[32m    "node_modules/mime-types": {[m
[32m+[m[32m      "version": "2.1.35",[m
[32m+[m[32m      "resolved": "https://registry.npmjs.org/mime-types/-/mime-types-2.1.35.tgz",[m
[32m+[m[32m      "integrity": "sha512-ZDY+bPm5zTTF+YpCrAU9nK0UgICYPT0QtT1NZWFv4s++TNkcgVaT0g6+4R2uI4MjQjzysHB1zxuWL50hzaeXiw==",[m
[32m+[m[32m      "license": "MIT",[m
[32m+[m[32m      "dependencies": {[m
[32m+[m[32m        "mime-db": "1.52.0"[m
[32m+[m[32m      },[m
[32m+[m[32m      "engines": {[m
[32m+[m[32m        "node": ">= 0.6"[m
[32m+[m[32m      }[m
[32m+[m[32m    },[m
[32m+[m[32m    "node_modules/minimatch": {[m
[32m+[m[32m      "version": "3.1.2",[m
[32m+[m[32m      "resolved": "https://registry.npmjs.org/minimatch/-/minimatch-3.1.2.tgz",[m
[32m+[m[32m      "integrity": "sha512-J7p63hRiAjw1NDEww1W7i37+ByIrOWO5XQQAzZ3VOcL0PNybwpfmV/N05zFAzwQ9USyEcX6t3UO+K5aqBQOIHw==",[m
[32m+[m[32m      "dev": true,[m
[32m+[m[32m      "license": "ISC",[m
[32m+[m[32m      "dependencies": {[m
[32m+[m[32m        "brace-expansion": "^1.1.7"[m
[32m+[m[32m      },[m
[32m+[m[32m      "engines": {[m
[32m+[m[32m        "node": "*"[m
[32m+[m[32m      }[m
[32m+[m[32m    },[m
[32m+[m[32m    "node_modules/ms": {[m
[32m+[m[32m      "version": "2.1.3",[m
[32m+[m[32m      "resolved": "https://registry.npmjs.org/ms/-/ms-2.1.3.tgz",[m
[32m+[m[32m      "integrity": "sha512-6FlzubTLZG3J2a/NVCAleEhjzq5oxgHyaCU9yYXvcLsvoVaHJq/s5xXI6/XXP6tz7R9xAOtHnSO/tXtF3WRTlA==",[m
[32m+[m[32m      "dev": true,[m
[32m+[m[32m      "license": "MIT"[m
[32m+[m[32m    },[m
[32m+[m[32m    "node_modules/nanoid": {[m
[32m+[m[32m      "version": "3.3.11",[m
[32m+[m[32m      "resolved": "https://registry.npmjs.org/nanoid/-/nanoid-3.3.11.tgz",[m
[32m+[m[32m      "integrity": "sha512-N8SpfPUnUp1bK+PMYW8qSWdl9U+wwNWI4QKxOYDy9JAro3WMX7p2OeVRF9v+347pnakNevPmiHhNmZ2HbFA76w==",[m
[32m+[m[32m      "funding": [[m
[32m+[m[32m        {[m
[32m+[m[32m          "type": "github",[m
[32m+[m[32m          "url": "https://github.com/sponsors/ai"[m
[32m+[m[32m        }[m
[32m+[m[32m      ],[m
[32m+[m[32m      "license": "MIT",[m
[32m+[m[32m      "bin": {[m
[32m+[m[32m        "nanoid": "bin/nanoid.cjs"[m
[32m+[m[32m      },[m
[32m+[m[32m      "engines": {[m
[32m+[m[32m        "node": "^10 || ^12 || ^13.7 || ^14 || >=15.0.1"[m
[32m+[m[32m      }[m
[32m+[m[32m    },[m
[32m+[m[32m    "node_modules/natural-compare": {[m
[32m+[m[32m      "version": "1.4.0",[m
[32m+[m[32m      "resolved": "https://registry.npmjs.org/natural-compare/-/natural-compare-1.4.0.tgz",[m
[32m+[m[32m      "integrity": "sha512-OWND8ei3VtNC9h7V60qff3SVobHr996CTwgxubgyQYEpg290h9J0buyECNNJexkFm5sOajh5G116RYA1c8ZMSw==",[m
[32m+[m[32m      "dev": true,[m
[32m+[m[32m      "license": "MIT"[m
[32m+[m[32m    },[m
[32m+[m[32m    "node_modules/node-releases": {[m
[32m+[m[32m      "version": "2.0.19",[m
[32m+[m[32m      "resolved": "https://registry.npmjs.org/node-releases/-/node-releases-2.0.19.tgz",[m
[32m+[m[32m      "integrity": "sha512-xxOWJsBKtzAq7DY0J+DTzuz58K8e7sJbdgwkbMWQe8UYB6ekmsQ45q0M/tJDsGaZmbC+l7n57UV8Hl5tHxO9uw==",[m
[32m+[m[32m      "dev": true,[m
[32m+[m[32m      "license": "MIT"[m
[32m+[m[32m    },[m
[32m+[m[32m    "node_modules/optionator": {[m
[32m+[m[32m      "version": "0.9.4",[m
[32m+[m[32m      "resolved": "https://registry.npmjs.org/optionator/-/optionator-0.9.4.tgz",[m
[32m+[m[32m      "integrity": "sha512-6IpQ7mKUxRcZNLIObR0hz7lxsapSSIYNZJwXPGeF0mTVqGKFIXj1DQcMoT22S3ROcLyY/rz0PWaWZ9ayWmad9g==",[m
[32m+[m[32m      "dev": true,[m
[32m+[m[32m      "license": "MIT",[m
[32m+[m[32m      "dependencies": {[m
[32m+[m[32m        "deep-is": "^0.1.3",[m
[32m+[m[32m        "fast-levenshtein": "^2.0.6",[m
[32m+[m[32m        "levn": "^0.4.1",[m
[32m+[m[32m        "prelude-ls": "^1.2.1",[m
[32m+[m[32m        "type-check": "^0.4.0",[m
[32m+[m[32m        "word-wrap": "^1.2.5"[m
[32m+[m[32m      },[m
[32m+[m[32m      "engines": {[m
[32m+[m[32m        "node": ">= 0.8.0"[m
[32m+[m[32m      }[m
[32m+[m[32m    },[m
[32m+[m[32m    "node_modules/p-limit": {[m
[32m+[m[32m      "version": "3.1.0",[m
[32m+[m[32m      "resolved": "https://registry.npmjs.org/p-limit/-/p-limit-3.1.0.tgz",[m
[32m+[m[32m      "integrity": "sha512-TYOanM3wGwNGsZN2cVTYPArw454xnXj5qmWF1bEoAc4+cU/ol7GVh7odevjp1FNHduHc3KZMcFduxU5Xc6uJRQ==",[m
[32m+[m[32m      "dev": true,[m
[32m+[m[32m      "license": "MIT",[m
[32m+[m[32m      "dependencies": {[m
[32m+[m[32m        "yocto-queue": "^0.1.0"[m
[32m+[m[32m      },[m
[32m+[m[32m      "engines": {[m
[32m+[m[32m        "node": ">=10"[m
[32m+[m[32m      },[m
[32m+[m[32m      "funding": {[m
[32m+[m[32m        "url": "https://github.com/sponsors/sindresorhus"[m
[32m+[m[32m      }[m
[32m+[m[32m    },[m
[32m+[m[32m    "node_modules/p-locate": {[m
[32m+[m[32m      "version": "5.0.0",[m
[32m+[m[32m      "resolved": "https://registry.npmjs.org/p-locate/-/p-locate-5.0.0.tgz",[m
[32m+[m[32m      "integrity": "sha512-LaNjtRWUBY++zB5nE/NwcaoMylSPk+S+ZHNB1TzdbMJMny6dynpAGt7X/tl/QYq3TIeE6nxHppbo2LGymrG5Pw==",[m
[32m+[m[32m      "dev": true,[m
[32m+[m[32m      "license": "MIT",[m
[32m+[m[32m      "dependencies": {[m
[32m+[m[32m        "p-limit": "^3.0.2"[m
[32m+[m[32m      },[m
[32m+[m[32m      "engines": {[m
[32m+[m[32m        "node": ">=10"[m
[32m+[m[32m      },[m
[32m+[m[32m      "funding": {[m
[32m+[m[32m        "url": "https://github.com/sponsors/sindresorhus"[m
[32m+[m[32m      }[m
[32m+[m[32m    },[m
[32m+[m[32m    "node_modules/parent-module": {[m
[32m+[m[32m      "version": "1.0.1",[m
[32m+[m[32m      "resolved": "https://registry.npmjs.org/parent-module/-/parent-module-1.0.1.tgz",[m
[32m+[m[32m      "integrity": "sha512-GQ2EWRpQV8/o+Aw8YqtfZZPfNRWZYkbidE9k5rpl/hC3vtHHBfGm2Ifi6qWV+coDGkrUKZAxE3Lot5kcsRlh+g==",[m
[32m+[m[32m      "dev": true,[m
[32m+[m[32m      "license": "MIT",[m
[32m+[m[32m      "dependencies": {[m
[32m+[m[32m        "callsites": "^3.0.0"[m
[32m+[m[32m      },[m
[32m+[m[32m      "engines": {[m
[32m+[m[32m        "node": ">=6"[m
[32m+[m[32m      }[m
[32m+[m[32m    },[m
[32m+[m[32m    "node_modules/path-exists": {[m
[32m+[m[32m      "version": "4.0.0",[m
[32m+[m[32m      "resolved": "https://registry.npmjs.org/path-exists/-/path-exists-4.0.0.tgz",[m
[32m+[m[32m      "integrity": "sha512-ak9Qy5Q7jYb2Wwcey5Fpvg2KoAc/ZIhLSLOSBmRmygPsGwkVVt0fZa0qrtMz+m6tJTAHfZQ8FnmB4MG4LWy7/w==",[m
[32m+[m[32m      "dev": true,[m
[32m+[m[32m      "license": "MIT",[m
[32m+[m[32m      "engines": {[m
[32m+[m[32m        "node": ">=8"[m
[32m+[m[32m      }[m
[32m+[m[32m    },[m
[32m+[m[32m    "node_modules/path-key": {[m
[32m+[m[32m      "version": "3.1.1",[m
[32m+[m[32m      "resolved": "https://registry.npmjs.org/path-key/-/path-key-3.1.1.tgz",[m
[32m+[m[32m      "integrity": "sha512-ojmeN0qd+y0jszEtoY48r0Peq5dwMEkIlCOu6Q5f41lfkswXuKtYrhgoTpLnyIcHm24Uhqx+5Tqm2InSwLhE6Q==",[m
[32m+[m[32m      "dev": true,[m
[32m+[m[32m      "license": "MIT",[m
[32m+[m[32m      "engines": {[m
[32m+[m[32m        "node": ">=8"[m
[32m+[m[32m      }[m
[32m+[m[32m    },[m
[32m+[m[32m    "node_modules/picocolors": {[m
[32m+[m[32m      "version": "1.1.1",[m
[32m+[m[32m      "resolved": "https://registry.npmjs.org/picocolors/-/picocolors-1.1.1.tgz",[m
[32m+[m[32m      "integrity": "sha512-xceH2snhtb5M9liqDsmEw56le376mTZkEX/jEb/RxNFyegNul7eNslCXP9FDj/Lcu0X8KEyMceP2ntpaHrDEVA==",[m
[32m+[m[32m      "license": "ISC"[m
[32m+[m[32m    },[m
[32m+[m[32m    "node_modules/postcss": {[m
[32m+[m[32m      "version": "8.5.3",[m
[32m+[m[32m      "resolved": "https://registry.npmjs.org/postcss/-/postcss-8.5.3.tgz",[m
[32m+[m[32m      "integrity": "sha512-dle9A3yYxlBSrt8Fu+IpjGT8SY8hN0mlaA6GY8t0P5PjIOZemULz/E2Bnm/2dcUOena75OTNkHI76uZBNUUq3A==",[m
[32m+[m[32m      "funding": [[m
[32m+[m[32m        {[m
[32m+[m[32m          "type": "opencollective",[m
[32m+[m[32m          "url": "https://opencollective.com/postcss/"[m
[32m+[m[32m        },[m
[32m+[m[32m        {[m
[32m+[m[32m          "type": "tidelift",[m
[32m+[m[32m          "url": "https://tidelift.com/funding/github/npm/postcss"[m
[32m+[m[32m        },[m
[32m+[m[32m        {[m
[32m+[m[32m          "type": "github",[m
[32m+[m[32m          "url": "https://github.com/sponsors/ai"[m
[32m+[m[32m        }[m
[32m+[m[32m      ],[m
[32m+[m[32m      "license": "MIT",[m
[32m+[m[32m      "dependencies": {[m
[32m+[m[32m        "nanoid": "^3.3.8",[m
[32m+[m[32m        "picocolors": "^1.1.1",[m
[32m+[m[32m        "source-map-js": "^1.2.1"[m
[32m+[m[32m      },[m
[32m+[m[32m      "engines": {[m
[32m+[m[32m        "node": "^10 || ^12 || >=14"[m
[32m+[m[32m      }[m
[32m+[m[32m    },[m
[32m+[m[32m    "node_modules/prelude-ls": {[m
[32m+[m[32m      "version": "1.2.1",[m
[32m+[m[32m      "resolved": "https://registry.npmjs.org/prelude-ls/-/prelude-ls-1.2.1.tgz",[m
[32m+[m[32m      "integrity": "sha512-vkcDPrRZo1QZLbn5RLGPpg/WmIQ65qoWWhcGKf/b5eplkkarX0m9z8ppCat4mlOqUsWpyNuYgO3VRyrYHSzX5g==",[m
[32m+[m[32m      "dev": true,[m
[32m+[m[32m      "license": "MIT",[m
[32m+[m[32m      "engines": {[m
[32m+[m[32m        "node": ">= 0.8.0"[m
[32m+[m[32m      }[m
[32m+[m[32m    },[m
[32m+[m[32m    "node_modules/proxy-from-env": {[m
[32m+[m[32m      "version": "1.1.0",[m
[32m+[m[32m      "resolved": "https://registry.npmjs.org/proxy-from-env/-/proxy-from-env-1.1.0.tgz",[m
[32m+[m[32m      "integrity": "sha512-D+zkORCbA9f1tdWRK0RaCR3GPv50cMxcrz4X8k5LTSUD1Dkw47mKJEZQNunItRTkWwgtaUSo1RVFRIG9ZXiFYg==",[m
[32m+[m[32m      "license": "MIT"[m
[32m+[m[32m    },[m
[32m+[m[32m    "node_modules/punycode": {[m
[32m+[m[32m      "version": "2.3.1",[m
[32m+[m[32m      "resolved": "https://registry.npmjs.org/punycode/-/punycode-2.3.1.tgz",[m
[32m+[m[32m      "integrity": "sha512-vYt7UD1U9Wg6138shLtLOvdAu+8DsC/ilFtEVHcH+wydcSpNE20AfSOduf6MkRFahL5FY7X1oU7nKVZFtfq8Fg==",[m
[32m+[m[32m      "dev": true,[m
[32m+[m[32m      "license": "MIT",[m
[32m+[m[32m      "engines": {[m
[32m+[m[32m        "node": ">=6"[m
[32m+[m[32m      }[m
[32m+[m[32m    },[m
[32m+[m[32m    "node_modules/react": {[m
[32m+[m[32m      "version": "19.0.0",[m
[32m+[m[32m      "resolved": "https://registry.npmjs.org/react/-/react-19.0.0.tgz",[m
[32m+[m[32m      "integrity": "sha512-V8AVnmPIICiWpGfm6GLzCR/W5FXLchHop40W4nXBmdlEceh16rCN8O8LNWm5bh5XUX91fh7KpA+W0TgMKmgTpQ==",[m
[32m+[m[32m      "license": "MIT",[m
[32m+[m[32m      "engines": {[m
[32m+[m[32m        "node": ">=0.10.0"[m
[32m+[m[32m      }[m
[32m+[m[32m    },[m
[32m+[m[32m    "node_modules/react-dom": {[m
[32m+[m[32m      "version": "19.0.0",[m
[32m+[m[32m      "resolved": "https://registry.npmjs.org/react-dom/-/react-dom-19.0.0.tgz",[m
[32m+[m[32m      "integrity": "sha512-4GV5sHFG0e/0AD4X+ySy6UJd3jVl1iNsNHdpad0qhABJ11twS3TTBnseqsKurKcsNqCEFeGL3uLpVChpIO3QfQ==",[m
[32m+[m[32m      "license": "MIT",[m
[32m+[m[32m      "dependencies": {[m
[32m+[m[32m        "scheduler": "^0.25.0"[m
[32m+[m[32m      },[m
[32m+[m[32m      "peerDependencies": {[m
[32m+[m[32m        "react": "^19.0.0"[m
[32m+[m[32m      }[m
[32m+[m[32m    },[m
[32m+[m[32m    "node_modules/react-refresh": {[m
[32m+[m[32m      "version": "0.14.2",[m
[32m+[m[32m      "resolved": "https://registry.npmjs.org/react-refresh/-/react-refresh-0.14.2.tgz",[m
[32m+[m[32m      "integrity": "sha512-jCvmsr+1IUSMUyzOkRcvnVbX3ZYC6g9TDrDbFuFmRDq7PD4yaGbLKNQL6k2jnArV8hjYxh7hVhAZB6s9HDGpZA==",[m
[32m+[m[32m      "dev": true,[m
[32m+[m[32m      "license": "MIT",[m
[32m+[m[32m      "engines": {[m
[32m+[m[32m        "node": ">=0.10.0"[m
[32m+[m[32m      }[m
[32m+[m[32m    },[m
[32m+[m[32m    "node_modules/react-router": {[m
[32m+[m[32m      "version": "7.4.0",[m
[32m+[m[32m      "resolved": "https://registry.npmjs.org/react-router/-/react-router-7.4.0.tgz",[m
[32m+[m[32m      "integrity": "sha512-Y2g5ObjkvX3VFeVt+0CIPuYd9PpgqCslG7ASSIdN73LwA1nNWzcMLaoMRJfP3prZFI92svxFwbn7XkLJ+UPQ6A==",[m
[32m+[m[32m      "license": "MIT",[m
[32m+[m[32m      "dependencies": {[m
[32m+[m[32m        "@types/cookie": "^0.6.0",[m
[32m+[m[32m        "cookie": "^1.0.1",[m
[32m+[m[32m        "set-cookie-parser": "^2.6.0",[m
[32m+[m[32m        "turbo-stream": "2.4.0"[m
[32m+[m[32m      },[m
[32m+[m[32m      "engines": {[m
[32m+[m[32m        "node": ">=20.0.0"[m
[32m+[m[32m      },[m
[32m+[m[32m      "peerDependencies": {[m
[32m+[m[32m        "react": ">=18",[m
[32m+[m[32m        "react-dom": ">=18"[m
[32m+[m[32m      },[m
[32m+[m[32m      "peerDependenciesMeta": {[m
[32m+[m[32m        "react-dom": {[m
[32m+[m[32m          "optional": true[m
[32m+[m[32m        }[m
[32m+[m[32m      }[m
[32m+[m[32m    },[m
[32m+[m[32m    "node_modules/react-router-dom": {[m
[32m+[m[32m      "version": "7.4.0",[m
[32m+[m[32m      "resolved": "https://registry.npmjs.org/react-router-dom/-/react-router-dom-7.4.0.tgz",[m
[32m+[m[32m      "integrity": "sha512-VlksBPf3n2bijPvnA7nkTsXxMAKOj+bWp4R9c3i+bnwlSOFAGOkJkKhzy/OsRkWaBMICqcAl1JDzh9ZSOze9CA==",[m
[32m+[m[32m      "license": "MIT",[m
[32m+[m[32m      "dependencies": {[m
[32m+[m[32m        "react-router": "7.4.0"[m
[32m+[m[32m      },[m
[32m+[m[32m      "engines": {[m
[32m+[m[32m        "node": ">=20.0.0"[m
[32m+[m[32m      },[m
[32m+[m[32m      "peerDependencies": {[m
[32m+[m[32m        "react": ">=18",[m
[32m+[m[32m        "react-dom": ">=18"[m
[32m+[m[32m      }[m
[32m+[m[32m    },[m
[32m+[m[32m    "node_modules/resolve-from": {[m
[32m+[m[32m      "version": "4.0.0",[m
[32m+[m[32m      "resolved": "https://registry.npmjs.org/resolve-from/-/resolve-from-4.0.0.tgz",[m
[32m+[m[32m      "integrity": "sha512-pb/MYmXstAkysRFx8piNI1tGFNQIFA3vkE3Gq4EuA1dF6gHp/+vgZqsCGJapvy8N3Q+4o7FwvquPJcnZ7RYy4g==",[m
[32m+[m[32m      "dev": true,[m
[32m+[m[32m      "license": "MIT",[m
[32m+[m[32m      "engines": {[m
[32m+[m[32m        "node": ">=4"[m
[32m+[m[32m      }[m
[32m+[m[32m    },[m
[32m+[m[32m    "node_modules/rollup": {[m
[32m+[m[32m      "version": "4.37.0",[m
[32m+[m[32m      "resolved": "https://registry.npmjs.org/rollup/-/rollup-4.37.0.tgz",[m
[32m+[m[32m      "integrity": "sha512-iAtQy/L4QFU+rTJ1YUjXqJOJzuwEghqWzCEYD2FEghT7Gsy1VdABntrO4CLopA5IkflTyqNiLNwPcOJ3S7UKLg==",[m
[32m+[m[32m      "license": "MIT",[m
[32m+[m[32m      "dependencies": {[m
[32m+[m[32m        "@types/estree": "1.0.6"[m
[32m+[m[32m      },[m
[32m+[m[32m      "bin": {[m
[32m+[m[32m        "rollup": "dist/bin/rollup"[m
[32m+[m[32m      },[m
[32m+[m[32m      "engines": {[m
[32m+[m[32m        "node": ">=18.0.0",[m
[32m+[m[32m        "npm": ">=8.0.0"[m
[32m+[m[32m      },[m
[32m+[m[32m      "optionalDependencies": {[m
[32m+[m[32m        "@rollup/rollup-android-arm-eabi": "4.37.0",[m
[32m+[m[32m        "@rollup/rollup-android-arm64": "4.37.0",[m
[32m+[m[32m        "@rollup/rollup-darwin-arm64": "4.37.0",[m
[32m+[m[32m        "@rollup/rollup-darwin-x64": "4.37.0",[m
[32m+[m[32m        "@rollup/rollup-freebsd-arm64": "4.37.0",[m
[32m+[m[32m        "@rollup/rollup-freebsd-x64": "4.37.0",[m
[32m+[m[32m        "@rollup/rollup-linux-arm-gnueabihf": "4.37.0",[m
[32m+[m[32m        "@rollup/rollup-linux-arm-musleabihf": "4.37.0",[m
[32m+[m[32m        "@rollup/rollup-linux-arm64-gnu": "4.37.0",[m
[32m+[m[32m        "@rollup/rollup-linux-arm64-musl": "4.37.0",[m
[32m+[m[32m        "@rollup/rollup-linux-loongarch64-gnu": "4.37.0",[m
[32m+[m[32m        "@rollup/rollup-linux-powerpc64le-gnu": "4.37.0",[m
[32m+[m[32m        "@rollup/rollup-linux-riscv64-gnu": "4.37.0",[m
[32m+[m[32m        "@rollup/rollup-linux-riscv64-musl": "4.37.0",[m
[32m+[m[32m        "@rollup/rollup-linux-s390x-gnu": "4.37.0",[m
[32m+[m[32m        "@rollup/rollup-linux-x64-gnu": "4.37.0",[m
[32m+[m[32m        "@rollup/rollup-linux-x64-musl": "4.37.0",[m
[32m+[m[32m        "@rollup/rollup-win32-arm64-msvc": "4.37.0",[m
[32m+[m[32m        "@rollup/rollup-win32-ia32-msvc": "4.37.0",[m
[32m+[m[32m        "@rollup/rollup-win32-x64-msvc": "4.37.0",[m
[32m+[m[32m        "fsevents": "~2.3.2"[m
[32m+[m[32m      }[m
[32m+[m[32m    },[m
[32m+[m[32m    "node_modules/scheduler": {[m
[32m+[m[32m      "version": "0.25.0",[m
[32m+[m[32m      "resolved": "https://registry.npmjs.org/scheduler/-/scheduler-0.25.0.tgz",[m
[32m+[m[32m      "integrity": "sha512-xFVuu11jh+xcO7JOAGJNOXld8/TcEHK/4CituBUeUb5hqxJLj9YuemAEuvm9gQ/+pgXYfbQuqAkiYu+u7YEsNA==",[m
[32m+[m[32m      "license": "MIT"[m
[32m+[m[32m    },[m
[32m+[m[32m    "node_modules/semver": {[m
[32m+[m[32m      "version": "6.3.1",[m
[32m+[m[32m      "resolved": "https://registry.npmjs.org/semver/-/semver-6.3.1.tgz",[m
[32m+[m[32m      "integrity": "sha512-BR7VvDCVHO+q2xBEWskxS6DJE1qRnb7DxzUrogb71CWoSficBxYsiAGd+Kl0mmq/MprG9yArRkyrQxTO6XjMzA==",[m
[32m+[m[32m      "dev": true,[m
[32m+[m[32m      "license": "ISC",[m
[32m+[m[32m      "bin": {[m
[32m+[m[32m        "semver": "bin/semver.js"[m
[32m+[m[32m      }[m
[32m+[m[32m    },[m
[32m+[m[32m    "node_modules/set-cookie-parser": {[m
[32m+[m[32m      "version": "2.7.1",[m
[32m+[m[32m      "resolved": "https://registry.npmjs.org/set-cookie-parser/-/set-cookie-parser-2.7.1.tgz",[m
[32m+[m[32m      "integrity": "sha512-IOc8uWeOZgnb3ptbCURJWNjWUPcO3ZnTTdzsurqERrP6nPyv+paC55vJM0LpOlT2ne+Ix+9+CRG1MNLlyZ4GjQ==",[m
[32m+[m[32m      "license": "MIT"[m
[32m+[m[32m    },[m
[32m+[m[32m    "node_modules/shebang-command": {[m
[32m+[m[32m      "version": "2.0.0",[m
[32m+[m[32m      "resolved": "https://registry.npmjs.org/shebang-command/-/shebang-command-2.0.0.tgz",[m
[32m+[m[32m      "integrity": "sha512-kHxr2zZpYtdmrN1qDjrrX/Z1rR1kG8Dx+gkpK1G4eXmvXswmcE1hTWBWYUzlraYw1/yZp6YuDY77YtvbN0dmDA==",[m
[32m+[m[32m      "dev": true,[m
[32m+[m[32m      "license": "MIT",[m
[32m+[m[32m      "dependencies": {[m
[32m+[m[32m        "shebang-regex": "^3.0.0"[m
[32m+[m[32m      },[m
[32m+[m[32m      "engines": {[m
[32m+[m[32m        "node": ">=8"[m
[32m+[m[32m      }[m
[32m+[m[32m    },[m
[32m+[m[32m    "node_modules/shebang-regex": {[m
[32m+[m[32m      "version": "3.0.0",[m
[32m+[m[32m      "resolved": "https://registry.npmjs.org/shebang-regex/-/shebang-regex-3.0.0.tgz",[m
[32m+[m[32m      "integrity": "sha512-7++dFhtcx3353uBaq8DDR4NuxBetBzC7ZQOhmTQInHEd6bSrXdiEyzCvG07Z44UYdLShWUyXt5M/yhz8ekcb1A==",[m
[32m+[m[32m      "dev": true,[m
[32m+[m[32m      "license": "MIT",[m
[32m+[m[32m      "engines": {[m
[32m+[m[32m        "node": ">=8"[m
[32m+[m[32m      }[m
[32m+[m[32m    },[m
[32m+[m[32m    "node_modules/source-map-js": {[m
[32m+[m[32m      "version": "1.2.1",[m
[32m+[m[32m      "resolved": "https://registry.npmjs.org/source-map-js/-/source-map-js-1.2.1.tgz",[m
[32m+[m[32m      "integrity": "sha512-UXWMKhLOwVKb728IUtQPXxfYU+usdybtUrK/8uGE8CQMvrhOpwvzDBwj0QhSL7MQc7vIsISBG8VQ8+IDQxpfQA==",[m
[32m+[m[32m      "license": "BSD-3-Clause",[m
[32m+[m[32m      "engines": {[m
[32m+[m[32m        "node": ">=0.10.0"[m
[32m+[m[32m      }[m
[32m+[m[32m    },[m
[32m+[m[32m    "node_modules/strip-json-comments": {[m
[32m+[m[32m      "version": "3.1.1",[m
[32m+[m[32m      "resolved": "https://registry.npmjs.org/strip-json-comments/-/strip-json-comments-3.1.1.tgz",[m
[32m+[m[32m      "integrity": "sha512-6fPc+R4ihwqP6N/aIv2f1gMH8lOVtWQHoqC4yK6oSDVVocumAsfCqjkXnqiYMhmMwS/mEHLp7Vehlt3ql6lEig==",[m
[32m+[m[32m      "dev": true,[m
[32m+[m[32m      "license": "MIT",[m
[32m+[m[32m      "engines": {[m
[32m+[m[32m        "node": ">=8"[m
[32m+[m[32m      },[m
[32m+[m[32m      "funding": {[m
[32m+[m[32m        "url": "https://github.com/sponsors/sindresorhus"[m
[32m+[m[32m      }[m
[32m+[m[32m    },[m
[32m+[m[32m    "node_modules/supports-color": {[m
[32m+[m[32m      "version": "7.2.0",[m
[32m+[m[32m      "resolved": "https://registry.npmjs.org/supports-color/-/supports-color-7.2.0.tgz",[m
[32m+[m[32m      "integrity": "sha512-qpCAvRl9stuOHveKsn7HncJRvv501qIacKzQlO/+Lwxc9+0q2wLyv4Dfvt80/DPn2pqOBsJdDiogXGR9+OvwRw==",[m
[32m+[m[32m      "dev": true,[m
[32m+[m[32m      "license": "MIT",[m
[32m+[m[32m      "dependencies": {[m
[32m+[m[32m        "has-flag": "^4.0.0"[m
[32m+[m[32m      },[m
[32m+[m[32m      "engines": {[m
[32m+[m[32m        "node": ">=8"[m
[32m+[m[32m      }[m
[32m+[m[32m    },[m
[32m+[m[32m    "node_modules/tailwindcss": {[m
[32m+[m[32m      "version": "4.0.15",[m
[32m+[m[32m      "resolved": "https://registry.npmjs.org/tailwindcss/-/tailwindcss-4.0.15.tgz",[m
[32m+[m[32m      "integrity": "sha512-6ZMg+hHdMJpjpeCCFasX7K+U615U9D+7k5/cDK/iRwl6GptF24+I/AbKgOnXhVKePzrEyIXutLv36n4cRsq3Sg==",[m
[32m+[m[32m      "license": "MIT"[m
[32m+[m[32m    },[m
[32m+[m[32m    "node_modules/tapable": {[m
[32m+[m[32m      "version": "2.2.1",[m
[32m+[m[32m      "resolved": "https://registry.npmjs.org/tapable/-/tapable-2.2.1.tgz",[m
[32m+[m[32m      "integrity": "sha512-GNzQvQTOIP6RyTfE2Qxb8ZVlNmw0n88vp1szwWRimP02mnTsx3Wtn5qRdqY9w2XduFNUgvOwhNnQsjwCp+kqaQ==",[m
[32m+[m[32m      "license": "MIT",[m
[32m+[m[32m      "engines": {[m
[32m+[m[32m        "node": ">=6"[m
[32m+[m[32m      }[m
[32m+[m[32m    },[m
[32m+[m[32m    "node_modules/turbo-stream": {[m
[32m+[m[32m      "version": "2.4.0",[m
[32m+[m[32m      "resolved": "https://registry.npmjs.org/turbo-stream/-/turbo-stream-2.4.0.tgz",[m
[32m+[m[32m      "integrity": "sha512-FHncC10WpBd2eOmGwpmQsWLDoK4cqsA/UT/GqNoaKOQnT8uzhtCbg3EoUDMvqpOSAI0S26mr0rkjzbOO6S3v1g==",[m
[32m+[m[32m      "license": "ISC"[m
[32m+[m[32m    },[m
[32m+[m[32m    "node_modules/type-check": {[m
[32m+[m[32m      "version": "0.4.0",[m
[32m+[m[32m      "resolved": "https://registry.npmjs.org/type-check/-/type-check-0.4.0.tgz",[m
[32m+[m[32m      "integrity": "sha512-XleUoc9uwGXqjWwXaUTZAmzMcFZ5858QA2vvx1Ur5xIcixXIP+8LnFDgRplU30us6teqdlskFfu+ae4K79Ooew==",[m
[32m+[m[32m      "dev": true,[m
[32m+[m[32m      "license": "MIT",[m
[32m+[m[32m      "dependencies": {[m
[32m+[m[32m        "prelude-ls": "^1.2.1"[m
[32m+[m[32m      },[m
[32m+[m[32m      "engines": {[m
[32m+[m[32m        "node": ">= 0.8.0"[m
[32m+[m[32m      }[m
[32m+[m[32m    },[m
[32m+[m[32m    "node_modules/update-browserslist-db": {[m
[32m+[m[32m      "version": "1.1.3",[m
[32m+[m[32m      "resolved": "https://registry.npmjs.org/update-browserslist-db/-/update-browserslist-db-1.1.3.tgz",[m
[32m+[m[32m      "integrity": "sha512-UxhIZQ+QInVdunkDAaiazvvT/+fXL5Osr0JZlJulepYu6Jd7qJtDZjlur0emRlT71EN3ScPoE7gvsuIKKNavKw==",[m
[32m+[m[32m      "dev": true,[m
[32m+[m[32m      "funding": [[m
[32m+[m[32m        {[m
[32m+[m[32m          "type": "opencollective",[m
[32m+[m[32m          "url": "https://opencollective.com/browserslist"[m
[32m+[m[32m        },[m
[32m+[m[32m        {[m
[32m+[m[32m          "type": "tidelift",[m
[32m+[m[32m          "url": "https://tidelift.com/funding/github/npm/browserslist"[m
[32m+[m[32m        },[m
[32m+[m[32m        {[m
[32m+[m[32m          "type": "github",[m
[32m+[m[32m          "url": "https://github.com/sponsors/ai"[m
[32m+[m[32m        }[m
[32m+[m[32m      ],[m
[32m+[m[32m      "license": "MIT",[m
[32m+[m[32m      "dependencies": {[m
[32m+[m[32m        "escalade": "^3.2.0",[m
[32m+[m[32m        "picocolors": "^1.1.1"[m
[32m+[m[32m      },[m
[32m+[m[32m      "bin": {[m
[32m+[m[32m        "update-browserslist-db": "cli.js"[m
[32m+[m[32m      },[m
[32m+[m[32m      "peerDependencies": {[m
[32m+[m[32m        "browserslist": ">= 4.21.0"[m
[32m+[m[32m      }[m
[32m+[m[32m    },[m
[32m+[m[32m    "node_modules/uri-js": {[m
[32m+[m[32m      "version": "4.4.1",[m
[32m+[m[32m      "resolved": "https://registry.npmjs.org/uri-js/-/uri-js-4.4.1.tgz",[m
[32m+[m[32m      "integrity": "sha512-7rKUyy33Q1yc98pQ1DAmLtwX109F7TIfWlW1Ydo8Wl1ii1SeHieeh0HHfPeL2fMXK6z0s8ecKs9frCuLJvndBg==",[m
[32m+[m[32m      "dev": true,[m
[32m+[m[32m      "license": "BSD-2-Clause",[m
[32m+[m[32m      "dependencies": {[m
[32m+[m[32m        "punycode": "^2.1.0"[m
[32m+[m[32m      }[m
[32m+[m[32m    },[m
[32m+[m[32m    "node_modules/vite": {[m
[32m+[m[32m      "version": "6.2.2",[m
[32m+[m[32m      "resolved": "https://registry.npmjs.org/vite/-/vite-6.2.2.tgz",[m
[32m+[m[32m      "integrity": "sha512-yW7PeMM+LkDzc7CgJuRLMW2Jz0FxMOsVJ8Lv3gpgW9WLcb9cTW+121UEr1hvmfR7w3SegR5ItvYyzVz1vxNJgQ==",[m
[32m+[m[32m      "license": "MIT",[m
[32m+[m[32m      "dependencies": {[m
[32m+[m[32m        "esbuild": "^0.25.0",[m
[32m+[m[32m        "postcss": "^8.5.3",[m
[32m+[m[32m        "rollup": "^4.30.1"[m
[32m+[m[32m      },[m
[32m+[m[32m      "bin": {[m
[32m+[m[32m        "vite": "bin/vite.js"[m
[32m+[m[32m      },[m
[32m+[m[32m      "engines": {[m
[32m+[m[32m        "node": "^18.0.0 || ^20.0.0 || >=22.0.0"[m
[32m+[m[32m      },[m
[32m+[m[32m      "funding": {[m
[32m+[m[32m        "url": "https://github.com/vitejs/vite?sponsor=1"[m
[32m+[m[32m      },[m
[32m+[m[32m      "optionalDependencies": {[m
[32m+[m[32m        "fsevents": "~2.3.3"[m
[32m+[m[32m      },[m
[32m+[m[32m      "peerDependencies": {[m
[32m+[m[32m        "@types/node": "^18.0.0 || ^20.0.0 || >=22.0.0",[m
[32m+[m[32m        "jiti": ">=1.21.0",[m
[32m+[m[32m        "less": "*",[m
[32m+[m[32m        "lightningcss": "^1.21.0",[m
[32m+[m[32m        "sass": "*",[m
[32m+[m[32m        "sass-embedded": "*",[m
[32m+[m[32m        "stylus": "*",[m
[32m+[m[32m        "sugarss": "*",[m
[32m+[m[32m        "terser": "^5.16.0",[m
[32m+[m[32m        "tsx": "^4.8.1",[m
[32m+[m[32m        "yaml": "^2.4.2"[m
[32m+[m[32m      },[m
[32m+[m[32m      "peerDependenciesMeta": {[m
[32m+[m[32m        "@types/node": {[m
[32m+[m[32m          "optional": true[m
[32m+[m[32m        },[m
[32m+[m[32m        "jiti": {[m
[32m+[m[32m          "optional": true[m
[32m+[m[32m        },[m
[32m+[m[32m        "less": {[m
[32m+[m[32m          "optional": true[m
[32m+[m[32m        },[m
[32m+[m[32m        "lightningcss": {[m
[32m+[m[32m          "optional": true[m
[32m+[m[32m        },[m
[32m+[m[32m        "sass": {[m
[32m+[m[32m          "optional": true[m
[32m+[m[32m        },[m
[32m+[m[32m        "sass-embedded": {[m
[32m+[m[32m          "optional": true[m
[32m+[m[32m        },[m
[32m+[m[32m        "stylus": {[m
[32m+[m[32m          "optional": true[m
[32m+[m[32m        },[m
[32m+[m[32m        "sugarss": {[m
[32m+[m[32m          "optional": true[m
[32m+[m[32m        },[m
[32m+[m[32m        "terser": {[m
[32m+[m[32m          "optional": true[m
[32m+[m[32m        },[m
[32m+[m[32m        "tsx": {[m
[32m+[m[32m          "optional": true[m
[32m+[m[32m        },[m
[32m+[m[32m        "yaml": {[m
[32m+[m[32m          "optional": true[m
[32m+[m[32m        }[m
[32m+[m[32m      }[m
[32m+[m[32m    },[m
[32m+[m[32m    "node_modules/which": {[m
[32m+[m[32m      "version": "2.0.2",[m
[32m+[m[32m      "resolved": "https://registry.npmjs.org/which/-/which-2.0.2.tgz",[m
[32m+[m[32m      "integrity": "sha512-BLI3Tl1TW3Pvl70l3yq3Y64i+awpwXqsGBYWkkqMtnbXgrMD+yj7rhW0kuEDxzJaYXGjEW5ogapKNMEKNMjibA==",[m
[32m+[m[32m      "dev": true,[m
[32m+[m[32m      "license": "ISC",[m
[32m+[m[32m      "dependencies": {[m
[32m+[m[32m        "isexe": "^2.0.0"[m
[32m+[m[32m      },[m
[32m+[m[32m      "bin": {[m
[32m+[m[32m        "node-which": "bin/node-which"[m
[32m+[m[32m      },[m
[32m+[m[32m      "engines": {[m
[32m+[m[32m        "node": ">= 8"[m
[32m+[m[32m      }[m
[32m+[m[32m    },[m
[32m+[m[32m    "node_modules/word-wrap": {[m
[32m+[m[32m      "version": "1.2.5",[m
[32m+[m[32m      "resolved": "https://registry.npmjs.org/word-wrap/-/word-wrap-1.2.5.tgz",[m
[32m+[m[32m      "integrity": "sha512-BN22B5eaMMI9UMtjrGd5g5eCYPpCPDUy0FJXbYsaT5zYxjFOckS53SQDE3pWkVoWpHXVb3BrYcEN4Twa55B5cA==",[m
[32m+[m[32m      "dev": true,[m
[32m+[m[32m      "license": "MIT",[m
[32m+[m[32m      "engines": {[m
[32m+[m[32m        "node": ">=0.10.0"[m
[32m+[m[32m      }[m
[32m+[m[32m    },[m
[32m+[m[32m    "node_modules/yallist": {[m
[32m+[m[32m      "version": "3.1.1",[m
[32m+[m[32m      "resolved": "https://registry.npmjs.org/yallist/-/yallist-3.1.1.tgz",[m
[32m+[m[32m      "integrity": "sha512-a4UGQaWPH59mOXUYnAG2ewncQS4i4F43Tv3JoAM+s2VDAmS9NsK8GpDMLrCHPksFT7h3K6TOoUNn2pb7RoXx4g==",[m
[32m+[m[32m      "dev": true,[m
[32m+[m[32m      "license": "ISC"[m
[32m+[m[32m    },[m
[32m+[m[32m    "node_modules/yocto-queue": {[m
[32m+[m[32m      "version": "0.1.0",[m
[32m+[m[32m      "resolved": "https://registry.npmjs.org/yocto-queue/-/yocto-queue-0.1.0.tgz",[m
[32m+[m[32m      "integrity": "sha512-rVksvsnNCdJ/ohGc6xgPwyN8eheCxsiLM8mxuE/t/mOVqJewPuO1miLpTHQiRgTKCLexL4MeAFVagts7HmNZ2Q==",[m
[32m+[m[32m      "dev": true,[m
[32m+[m[32m      "license": "MIT",[m
[32m+[m[32m      "engines": {[m
[32m+[m[32m        "node": ">=10"[m
[32m+[m[32m      },[m
[32m+[m[32m      "funding": {[m
[32m+[m[32m        "url": "https://github.com/sponsors/sindresorhus"[m
[32m+[m[32m      }[m
[32m+[m[32m    }[m
[32m+[m[32m  }[m
[32m+[m[32m}[m
[1mdiff --git a/frontend_LHB3/package.json b/frontend_LHB3/package.json[m
[1mnew file mode 100644[m
[1mindex 0000000..829aa5b[m
[1m--- /dev/null[m
[1m+++ b/frontend_LHB3/package.json[m
[36m@@ -0,0 +1,31 @@[m
[32m+[m[32m{[m
[32m+[m[32m  "name": "frontend_lhb3",[m
[32m+[m[32m  "private": true,[m
[32m+[m[32m  "version": "0.0.0",[m
[32m+[m[32m  "type": "module",[m
[32m+[m[32m  "scripts": {[m
[32m+[m[32m    "dev": "vite",[m
[32m+[m[32m    "build": "vite build",[m
[32m+[m[32m    "lint": "eslint .",[m
[32m+[m[32m    "preview": "vite preview"[m
[32m+[m[32m  },[m
[32m+[m[32m  "dependencies": {[m
[32m+[m[32m    "@tailwindcss/vite": "^4.0.15",[m
[32m+[m[32m    "axios": "^1.8.4",[m
[32m+[m[32m    "react": "^19.0.0",[m
[32m+[m[32m    "react-dom": "^19.0.0",[m
[32m+[m[32m    "react-router-dom": "^7.4.0",[m
[32m+[m[32m    "tailwindcss": "^4.0.15"[m
[32m+[m[32m  },[m
[32m+[m[32m  "devDependencies": {[m
[32m+[m[32m    "@eslint/js": "^9.21.0",[m
[32m+[m[32m    "@types/react": "^19.0.10",[m
[32m+[m[32m    "@types/react-dom": "^19.0.4",[m
[32m+[m[32m    "@vitejs/plugin-react": "^4.3.4",[m
[32m+[m[32m    "eslint": "^9.21.0",[m
[32m+[m[32m    "eslint-plugin-react-hooks": "^5.1.0",[m
[32m+[m[32m    "eslint-plugin-react-refresh": "^0.4.19",[m
[32m+[m[32m    "globals": "^15.15.0",[m
[32m+[m[32m    "vite": "^6.2.0"[m
[32m+[m[32m  }[m
[32m+[m[32m}[m
[1mdiff --git a/frontend_LHB3/src/App.css b/frontend_LHB3/src/App.css[m
[1mnew file mode 100644[m
[1mindex 0000000..944af73[m
[1m--- /dev/null[m
[1m+++ b/frontend_LHB3/src/App.css[m
[36m@@ -0,0 +1,40 @@[m
[32m+[m[32m@import "tailwindcss";[m
[32m+[m
[32m+[m[32m.app-container {[m
[32m+[m[32m    display: flex;[m
[32m+[m[32m    flex-direction: column;[m
[32m+[m[32m    height: 100vh;[m
[32m+[m[32m  }[m
[32m+[m[41m  [m
[32m+[m[32m  .content-wrapper {[m
[32m+[m[32m    display: flex;[m
[32m+[m[32m    flex-grow: 1;[m
[32m+[m[32m  }[m
[32m+[m[41m  [m
[32m+[m[32m  .main-content {[m
[32m+[m[32m    flex-grow: 1;[m
[32m+[m[32m    padding: 24px;[m
[32m+[m[32m    background-color: #F9FAFB; /* gray-50 */[m
[32m+[m[32m  }[m
[32m+[m[41m  [m
[32m+[m[32m  .content-card {[m
[32m+[m[32m    background-color: white;[m
[32m+[m[32m    padding: 24px;[m
[32m+[m[32m    border-radius: 8px;[m
[32m+[m[32m    box-shadow: 0 1px 3px rgba(0, 0, 0, 0.1);[m
[32m+[m[32m  }[m
[32m+[m[41m  [m
[32m+[m[32m  .content-title {[m
[32m+[m[32m    font-size: 20px;[m
[32m+[m[32m    font-weight: 600;[m
[32m+[m[32m    margin-bottom: 16px;[m
[32m+[m[32m  }[m
[32m+[m[41m  [m
[32m+[m[32m  .toggle-button {[m
[32m+[m[32m    margin-bottom: 16px;[m
[32m+[m[32m    padding: 8px 16px;[m
[32m+[m[32m    background-color: #E5E7EB; /* gray-200 */[m
[32m+[m[32m    border: none;[m
[32m+[m[32m    border-radius: 4px;[m
[32m+[m[32m    cursor: pointer;[m
[32m+[m[32m  }[m
\ No newline at end of file[m
[1mdiff --git a/frontend_LHB3/src/App.jsx b/frontend_LHB3/src/App.jsx[m
[1mnew file mode 100644[m
[1mindex 0000000..9a0f967[m
[1m--- /dev/null[m
[1m+++ b/frontend_LHB3/src/App.jsx[m
[36m@@ -0,0 +1,112 @@[m
[32m+[m[32mimport React, { useState } from 'react';[m
[32m+[m[32mimport { Route, Routes, useLocation, useNavigate, Navigate } from 'react-router-dom';[m
[32m+[m[32mimport Login from './pages/Login';[m
[32m+[m[32mimport Home from './pages/Home';[m
[32m+[m[32mimport LiveSchedule from './pages/LiveSchedule';[m
[32m+[m[32mimport Feedback from './pages/feedback';[m
[32m+[m[32mimport Request_booking from './pages/request_booking';[m
[32m+[m[32mimport Help from './pages/help';[m
[32m+[m[32mimport Status from './pages/Status';[m
[32m+[m[32mimport UserHistory from './pages/UserHistory';[m
[32m+[m[32mimport CreateUser from './pages/CreateUser';[m
[32m+[m[32mimport Adminviewbooking from './pages/Adminviewbooking';[m
[32m+[m
[32m+[m[32m// Import navbar components[m
[32m+[m[32mimport UserNavbar from './components/UserNavbar';[m
[32m+[m[32mimport AdminNavbar from './components/AdminNavbar';[m
[32m+[m[32mimport Header from './components/Header';[m
[32m+[m[32m// import AdminviewBooking from './pages/Adminviewbooking';[m
[32m+[m
[32m+[m[32m// TODO: Backend Integration Comments:[m
[32m+[m
[32m+[m[32m// 1. Authentication State Management:[m
[32m+[m[32m// - Replace local state with JWT token-based authentication[m
[32m+[m[32m// - Create an AuthContext using React Context API in src/contexts/AuthContext.jsx[m
[32m+[m[32m// - Store authentication tokens in secure HttpOnly cookies or localStorage (less secure)[m
[32m+[m
[32m+[m[32m// 2. API Integration Points:[m
[32m+[m[32m// - Create src/api/auth.js for authentication API calls[m
[32m+[m[32m// - Add login, logout, and token refresh functions[m
[32m+[m[32m// - Implement an axios interceptor to:[m
[32m+[m[32m//   a) Add authentication headers to all requests[m
[32m+[m[32m//   b) Handle 401 errors and refresh tokens or redirect to login[m
[32m+[m
[32m+[m[32m// 3. Protected Routes:[m
[32m+[m[32m// - Enhance the route protection to verify token validity[m
[32m+[m[32m// - Implement role-based access control for admin vs regular users[m
[32m+[m[32m// - Add API call to validate user session on app initialization[m
[32m+[m
[32m+[m[32m// 4. User Details:[m
[32m+[m[32m// - Fetch complete user profile from backend after login[m
[32m+[m[32m// - Store user details (name, email, role, permissions) in AuthContext[m
[32m+[m
[32m+[m[32m// 5. Logout Functionality:[m
[32m+[m[32m// - Clear tokens from storage[m
[32m+[m[32m// - Call backend API to invalidate the token on server[m
[32m+[m[32m// - Redirect to login page[m
[32m+[m
[32m+[m[32mconst App = () => {[m
[32m+[m[32m  const [userRole, setUserRole] = useState('');[m
[32m+[m[32m  const [isLoggedIn, setIsLoggedIn] = useState(false);[m
[32m+[m[32m  const location = useLocation();[m
[32m+[m[32m  const navigate = useNavigate();[m
[32m+[m[41m  [m
[32m+[m[32m  // Show navbar only if logged in and not on login page[m
[32m+[m[32m  const showNavbar = isLoggedIn && location.pathname !== '/login';[m
[32m+[m[41m  [m
[32m+[m[32m  // Function to handle login[m
[32m+[m[32m  const handleLogin = (email) => {[m
[32m+[m[32m    // Set user role based on email or any other logic[m
[32m+[m[32m    const role = email.includes('admin') ? 'admin' : 'user';[m
[32m+[m[32m    setUserRole(role);[m
[32m+[m[32m    setIsLoggedIn(true);[m
[32m+[m[32m    // Navigate to the request_booking page after successful login[m
[32m+[m[32m    navigate('/request_booking');[m
[32m+[m[32m  };[m
[32m+[m[41m  [m
[32m+[m[32m  // Function for navigation[m
[32m+[m[32m  const handleNavigation = (path) => {[m
[32m+[m[32m    navigate(path);[m
[32m+[m[32m  };[m
[32m+[m[41m  [m
[32m+[m[32m  return ([m
[32m+[m[32m    <div className="flex flex-col min-h-screen">[m
[32m+[m[32m      {showNavbar && <Header />}[m
[32m+[m[41m      [m
[32m+[m[32m      <div className="flex flex-grow">[m
[32m+[m[32m        {showNavbar && ([m
[32m+[m[32m          userRole === 'admin'[m
[32m+[m[32m            ? <AdminNavbar onNavigate={handleNavigation} currentPath={location.pathname} />[m
[32m+[m[32m            : <UserNavbar onNavigate={handleNavigation} currentPath={location.pathname} />[m
[32m+[m[32m        )}[m
[32m+[m[41m        [m
[32m+[m[32m        <div className={`flex-grow ${showNavbar ? 'p-4 bg-gray-50' : ''}`}>[m
[32m+[m[32m          <Routes>[m
[32m+[m[32m            {/* Redirect root to login if not logged in */}[m
[32m+[m[32m            <Route path="/" element={[m
[32m+[m[32m              isLoggedIn ? <Navigate to="/request_booking" /> : <Navigate to="/login" />[m
[32m+[m[32m            } />[m
[32m+[m[41m            [m
[32m+[m[32m            {/* Login route */}[m
[32m+[m[32m            <Route path="/login" element={[m
[32m+[m[32m              isLoggedIn ? <Navigate to="/request_booking" /> : <Login onLogin={handleLogin} />[m
[32m+[m[32m            } />[m
[32m+[m[41m            [m
[32m+[m[32m            {/* Protected routes */}[m
[32m+[m[32m            <Route path="/home" element={isLoggedIn ? <Home /> : <Navigate to="/login" />} />[m
[32m+[m[32m            <Route path="/history" element={isLoggedIn ? <UserHistory /> : <Navigate to="/login" />} />[m
[32m+[m[32m            <Route path="/live_schedule" element={isLoggedIn ? <LiveSchedule /> : <Navigate to="/login" />} />[m
[32m+[m[32m            <Route path="/feedback" element={isLoggedIn ? <Feedback /> : <Navigate to="/login" />} />[m
[32m+[m[32m            <Route path="/request_booking" element={isLoggedIn ? <Request_booking /> : <Navigate to="/login" />} />[m
[32m+[m[32m            <Route path="/help" element={isLoggedIn ? <Help /> : <Navigate to="/login" />} />[m
[32m+[m[32m            <Route path="/status" element={isLoggedIn ? <Status /> : <Navigate to="/login" />} />[m
[32m+[m[32m            <Route path="/create_user" element={isLoggedIn ? <CreateUser /> : <Navigate to="/login" />} />[m
[32m+[m[32m            <Route path="/admin_view_booking" element={isLoggedIn ? <Adminviewbooking /> : <Navigate to="/login" />} />[m
[32m+[m[32m          </Routes>[m
[32m+[m[32m        </div>[m
[32m+[m[32m      </div>[m
[32m+[m[32m    </div>[m
[32m+[m[32m  );[m
[32m+[m[32m};[m
[32m+[m
[32m+[m[32mexport default App;[m
\ No newline at end of file[m
[1mdiff --git a/frontend_LHB3/src/api/apiClient.js b/frontend_LHB3/src/api/apiClient.js[m
[1mnew file mode 100644[m
[1mindex 0000000..2f756b7[m
[1m--- /dev/null[m
[1m+++ b/frontend_LHB3/src/api/apiClient.js[m
[36m@@ -0,0 +1,74 @@[m
[32m+[m[32mimport axios from 'axios';[m
[32m+[m
[32m+[m[32m// Base API client configuration[m
[32m+[m[32mconst apiClient = axios.create({[m
[32m+[m[32m  baseURL: import.meta.env.VITE_API_BASE_URL || 'http://localhost:8000/api',[m
[32m+[m[32m  headers: {[m
[32m+[m[32m    'Content-Type': 'application/json',[m
[32m+[m[32m  },[m
[32m+[m[32m  timeout: 10000, // 10 seconds[m
[32m+[m[32m});[m
[32m+[m
[32m+[m[32m// Request interceptor[m
[32m+[m[32mapiClient.interceptors.request.use([m
[32m+[m[32m  (config) => {[m
[32m+[m[32m    // Get token from storage[m
[32m+[m[32m    const token = localStorage.getItem('auth_token');[m
[32m+[m[41m    [m
[32m+[m[32m    // Add token to headers if available[m
[32m+[m[32m    if (token) {[m
[32m+[m[32m      config.headers.Authorization = `Bearer ${token}`;[m
[32m+[m[32m    }[m
[32m+[m[41m    [m
[32m+[m[32m    return config;[m
[32m+[m[32m  },[m
[32m+[m[32m  (error) => {[m
[32m+[m[32m    return Promise.reject(error);[m
[32m+[m[32m  }[m
[32m+[m[32m);[m
[32m+[m
[32m+[m[32m// Response interceptor[m
[32m+[m[32mapiClient.interceptors.response.use([m
[32m+[m[32m  (response) => {[m
[32m+[m[32m    return response;[m
[32m+[m[32m  },[m
[32m+[m[32m  async (error) => {[m
[32m+[m[32m    const originalRequest = error.config;[m
[32m+[m[41m    [m
[32m+[m[32m    // Handle token expiration[m
[32m+[m[32m    if (error.response?.status === 401 && !originalRequest._retry) {[m
[32m+[m[32m      originalRequest._retry = true;[m
[32m+[m[41m      [m
[32m+[m[32m      try {[m
[32m+[m[32m        // Attempt to refresh token[m
[32m+[m[32m        const refreshToken = localStorage.getItem('refresh_token');[m
[32m+[m[32m        if (!refreshToken) {[m
[32m+[m[32m          throw new Error('No refresh token available');[m
[32m+[m[32m        }[m
[32m+[m[41m        [m
[32m+[m[32m        const response = await axios.post([m
[32m+[m[32m          `${apiClient.defaults.baseURL}/auth/refresh`,[m[41m [m
[32m+[m[32m          { refreshToken }[m
[32m+[m[32m        );[m
[32m+[m[41m        [m
[32m+[m[32m        const { token } = response.data;[m
[32m+[m[32m        localStorage.setItem('auth_token', token);[m
[32m+[m[41m        [m
[32m+[m[32m        // Retry the original request with new token[m
[32m+[m[32m        originalRequest.headers.Authorization = `Bearer ${token}`;[m
[32m+[m[32m        return apiClient(originalRequest);[m
[32m+[m[32m      } catch (refreshError) {[m
[32m+[m[32m        // Redirect to login on refresh failure[m
[32m+[m[32m        localStorage.removeItem('auth_token');[m
[32m+[m[32m        localStorage.removeItem('refresh_token');[m
[32m+[m[32m        window.location.href = '/login';[m
[32m+[m[32m        return Promise.reject(refreshError);[m
[32m+[m[32m      }[m
[32m+[m[32m    }[m
[32m+[m[41m    [m
[32m+[m[32m    // Handle other errors[m
[32m+[m[32m    return Promise.reject(error);[m
[32m+[m[32m  }[m
[32m+[m[32m);[m
[32m+[m
[32m+[m[32mexport default apiClient;[m
[1mdiff --git a/frontend_LHB3/src/assets/assets.js b/frontend_LHB3/src/assets/assets.js[m
[1mnew file mode 100644[m
[1mindex 0000000..2ee9faf[m
[1m--- /dev/null[m
[1m+++ b/frontend_LHB3/src/assets/assets.js[m
[36m@@ -0,0 +1,11 @@[m
[32m+[m[32m// Import the image directly[m
[32m+[m[32mimport iitk_logo from "./iitk_logo.png";[m
[32m+[m[32mimport lgpiitk from "./loginpageiitk.png";[m
[32m+[m
[32m+[m[32m// Export assets used in the application[m
[32m+[m[32mexport const assets = {[m
[32m+[m[32m  // Use the imported variable, not a string path[m
[32m+[m[32m  iitk_logo: iitk_logo,[m
[32m+[m[32m  loginpageiitk: lgpiitk,[m
[32m+[m[32m};[m
[32m+[m
[1mdiff --git a/frontend_LHB3/src/assets/iitk_logo.png b/frontend_LHB3/src/assets/iitk_logo.png[m
[1mnew file mode 100644[m
[1mindex 0000000..bc1c56e[m
Binary files /dev/null and b/frontend_LHB3/src/assets/iitk_logo.png differ
[1mdiff --git a/frontend_LHB3/src/assets/loginpageiitk.png b/frontend_LHB3/src/assets/loginpageiitk.png[m
[1mnew file mode 100644[m
[1mindex 0000000..c2058fe[m
Binary files /dev/null and b/frontend_LHB3/src/assets/loginpageiitk.png differ
[1mdiff --git a/frontend_LHB3/src/components/AdminNavbar.css b/frontend_LHB3/src/components/AdminNavbar.css[m
[1mnew file mode 100644[m
[1mindex 0000000..17f9096[m
[1m--- /dev/null[m
[1m+++ b/frontend_LHB3/src/components/AdminNavbar.css[m
[36m@@ -0,0 +1,46 @@[m
[32m+[m[32m.admin-navbar {[m
[32m+[m[32m    width: 200px;[m
[32m+[m[32m    background-color: #EFF6FF; /* blue-50 */[m
[32m+[m[32m    padding: 16px;[m
[32m+[m[32m    height: 100vh;[m
[32m+[m[32m  }[m
[32m+[m[41m  [m
[32m+[m[32m  .admin-nav-item {[m
[32m+[m[32m    width: 100%;[m
[32m+[m[32m    border-radius: 9999px;[m
[32m+[m[32m    padding: 8px 16px;[m
[32m+[m[32m    margin-bottom: 12px;[m
[32m+[m[32m    text-align: center;[m
[32m+[m[32m    background-color: #DBEAFE; /* blue-100 */[m
[32m+[m[32m    color: #1E3A8A; /* blue-900 */[m
[32m+[m[32m    transition: background-color 0.2s, color 0.2s;[m
[32m+[m[32m    cursor: pointer;[m
[32m+[m[32m    border: none;[m
[32m+[m[32m    font-size: 14px;[m
[32m+[m[32m    display: flex;[m
[32m+[m[32m    align-items: center;[m
[32m+[m[32m    justify-content: center;[m
[32m+[m[32m  }[m
[32m+[m[41m  [m
[32m+[m[32m  .admin-nav-item:hover {[m
[32m+[m[32m    background-color: #BFDBFE; /* blue-200 */[m
[32m+[m[32m  }[m
[32m+[m[41m  [m
[32m+[m[32m  .admin-nav-item.active {[m
[32m+[m[32m    background-color: #3B82F6; /* blue-500 */[m
[32m+[m[32m    color: white;[m
[32m+[m[32m  }[m
[32m+[m[41m  [m
[32m+[m[32m  .admin-info-icon {[m
[32m+[m[32m    display: inline-flex;[m
[32m+[m[32m    align-items: center;[m
[32m+[m[32m    justify-content: center;[m
[32m+[m[32m    width: 16px;[m
[32m+[m[32m    height: 16px;[m
[32m+[m[32m    margin-left: 4px;[m
[32m+[m[32m    font-size: 12px;[m
[32m+[m[32m    color: white;[m
[32m+[m[32m    background-color: #2563EB; /* blue-600 */[m
[32m+[m[32m    border-radius: 50%;[m
[32m+[m[32m  }[m
[32m+[m[41m  [m
\ No newline at end of file[m
[1mdiff --git a/frontend_LHB3/src/components/AdminNavbar.jsx b/frontend_LHB3/src/components/AdminNavbar.jsx[m
[1mnew file mode 100644[m
[1mindex 0000000..50724ab[m
[1m--- /dev/null[m
[1m+++ b/frontend_LHB3/src/components/AdminNavbar.jsx[m
[36m@@ -0,0 +1,30 @@[m
[32m+[m[32mimport React from 'react';[m
[32m+[m[32mimport './AdminNavbar.css';[m
[32m+[m
[32m+[m[32mconst AdminNavbar = ({ onNavigate, currentPath }) => {[m
[32m+[m[32m  // Map of navigation items to their respective routes[m
[32m+[m[32m  const navItems = [[m
[32m+[m[32m    { name: 'New', path: '/request_booking' },[m
[32m+[m[32m    { name: 'Live Schedule', path: '/live_schedule' },[m
[32m+[m[32m    { name: 'History', path: '/admin_view_booking' }, // Assuming Home page has history[m
[32m+[m[32m    { name: 'View Pending', path: '/pending' }, // You'll need to add this route[m
[32m+[m[32m    { name: 'Create New User', path: '/create_user' }, // You'll need to add this route[m
[32m+[m[32m  ];[m
[32m+[m
[32m+[m[32m  return ([m
[32m+[m[32m    <div className="admin-navbar">[m
[32m+[m[32m      {navItems.map((item) => ([m
[32m+[m[32m        <button[m
[32m+[m[32m          key={item.name}[m
[32m+[m[32m          onClick={() => onNavigate(item.path)}[m
[32m+[m[32m          className={`admin-nav-item ${currentPath === item.path ? 'active' : ''}`}[m
[32m+[m[32m        >[m
[32m+[m[32m          {item.name}[m
[32m+[m[32m          {item.name === 'New' && <span className="admin-info-icon">ⓘ</span>}[m
[32m+[m[32m        </button>[m
[32m+[m[32m      ))}[m
[32m+[m[32m    </div>[m
[32m+[m[32m  );[m
[32m+[m[32m};[m
[32m+[m
[32m+[m[32mexport default AdminNavbar;[m
\ No newline at end of file[m
[1mdiff --git a/frontend_LHB3/src/components/Header.css b/frontend_LHB3/src/components/Header.css[m
[1mnew file mode 100644[m
[1mindex 0000000..4081844[m
[1m--- /dev/null[m
[1m+++ b/frontend_LHB3/src/components/Header.css[m
[36m@@ -0,0 +1,40 @@[m
[32m+[m[32m.header {[m
[32m+[m[32m    width: 100%;[m
[32m+[m[32m    background-color: #EFF6FF; /* blue-50 */[m
[32m+[m[32m    padding: 16px;[m
[32m+[m[32m    display: flex;[m
[32m+[m[32m    justify-content: space-between;[m
[32m+[m[32m    align-items: center;[m
[32m+[m[32m    border-bottom: 1px solid #DBEAFE; /* blue-100 */[m
[32m+[m[32m  }[m
[32m+[m[41m  [m
[32m+[m[32m  .logo-container {[m
[32m+[m[32m    display: flex;[m
[32m+[m[32m    align-items: center;[m
[32m+[m[32m  }[m
[32m+[m[41m  [m
[32m+[m[32m  .logo {[m
[32m+[m[32m    height: 40px;[m
[32m+[m[32m    width: 40px;[m
[32m+[m[32m    margin-right: 12px;[m
[32m+[m[32m  }[m
[32m+[m[41m  [m
[32m+[m[32m  .title {[m
[32m+[m[32m    font-size: 20px;[m
[32m+[m[32m    font-weight: bold;[m
[32m+[m[32m    color: #1E3A8A; /* blue-900 */[m
[32m+[m[32m  }[m
[32m+[m[41m  [m
[32m+[m[32m  .logout-button {[m
[32m+[m[32m    background-color: #3B82F6; /* blue-500 */[m
[32m+[m[32m    color: white;[m
[32m+[m[32m    padding: 8px 24px;[m
[32m+[m[32m    border-radius: 9999px;[m
[32m+[m[32m    border: none;[m
[32m+[m[32m    cursor: pointer;[m
[32m+[m[32m    transition: background-color 0.2s;[m
[32m+[m[32m  }[m
[32m+[m[41m  [m
[32m+[m[32m  .logout-button:hover {[m
[32m+[m[32m    background-color: #2563EB; /* blue-600 */[m
[32m+[m[32m  }[m
\ No newline at end of file[m
[1mdiff --git a/frontend_LHB3/src/components/Header.jsx b/frontend_LHB3/src/components/Header.jsx[m
[1mnew file mode 100644[m
[1mindex 0000000..7825a47[m
[1m--- /dev/null[m
[1m+++ b/frontend_LHB3/src/components/Header.jsx[m
[36m@@ -0,0 +1,52 @@[m
[32m+[m[32mimport React from 'react';[m
[32m+[m[32mimport './Header.css';[m
[32m+[m[32m// Option 1: If your image is in the public folder[m
[32m+[m[32m// import iitk_logo from '../../public/assets/iitk_logo.png';[m
[32m+[m[32m// Option 2: If your image is in the assets folder inside src[m
[32m+[m[32mimport iitk_logo from '../assets/iitk_logo.png';[m
[32m+[m
[32m+[m[32m// TODO: Backend Integration Comments:[m
[32m+[m
[32m+[m[32m// 1. Logout Functionality:[m
[32m+[m[32m// - Replace window.location redirect with proper API call[m
[32m+[m[32m// - Create logout function in src/api/auth.js[m
[32m+[m[32m// - Call POST /api/auth/logout to invalidate token on server[m
[32m+[m[32m// - Clear local storage/cookies of authentication tokens[m
[32m+[m[32m// - Use React Router's navigate instead of window.location for better UX[m
[32m+[m
[32m+[m[32m// 2. User Information:[m
[32m+[m[32m// - Get user data from AuthContext instead of hardcoding[m
[32m+[m[32m// - Display user name/email in the header[m
[32m+[m[32m// - Consider adding a user dropdown menu with profile options[m
[32m+[m
[32m+[m[32m// 3. Notifications:[m
[32m+[m[32m// - Fetch notifications from backend API[m
[32m+[m[32m// - Add notification bell icon with counter[m
[32m+[m[32m// - Implement real-time notifications with WebSockets if needed[m
[32m+[m
[32m+[m[32m// 4. Session Management:[m
[32m+[m[32m// - Add session timeout warning[m
[32m+[m[32m// - Implement idle timeout detection[m
[32m+[m[32m// - Add option to extend session[m
[32m+[m
[32m+[m[32mconst Header = () => {[m
[32m+[m[32m  // Logout function[m
[32m+[m[32m  const handleLogout = () => {[m
[32m+[m[32m    // Add your logout logic here[m
[32m+[m[32m    window.location.href = '/login';[m
[32m+[m[32m  };[m
[32m+[m
[32m+[m[32m  return ([m
[32m+[m[32m    <div className="header">[m
[32m+[m[32m      <div className="logo-container">[m
[32m+[m[32m        <img src={iitk_logo} alt="IIT-K Logo" className="logo" />[m
[32m+[m[32m        <h1 className="title">IIT-K Lecture Hall Booking</h1>[m
[32m+[m[32m      </div>[m
[32m+[m[32m      <button className="logout-button" onClick={handleLogout}>[m
[32m+[m[32m        Logout[m
[32m+[m[32m      </button>[m
[32m+[m[32m    </div>[m
[32m+[m[32m  );[m
[32m+[m[32m};[m
[32m+[m
[32m+[m[32mexport default Header;[m
\ No newline at end of file[m
[1mdiff --git a/frontend_LHB3/src/components/UserNavbar.css b/frontend_LHB3/src/components/UserNavbar.css[m
[1mnew file mode 100644[m
[1mindex 0000000..fd939fa[m
[1m--- /dev/null[m
[1m+++ b/frontend_LHB3/src/components/UserNavbar.css[m
[36m@@ -0,0 +1,45 @@[m
[32m+[m[32m.user-navbar {[m
[32m+[m[32m    width: 200px;[m
[32m+[m[32m    background-color: #EFF6FF; /* blue-50 */[m
[32m+[m[32m    padding: 16px;[m
[32m+[m[32m    height: 100vh;[m
[32m+[m[32m  }[m
[32m+[m[41m  [m
[32m+[m[32m  .nav-item {[m
[32m+[m[32m    width: 100%;[m
[32m+[m[32m    border-radius: 9999px;[m
[32m+[m[32m    padding: 8px 16px;[m
[32m+[m[32m    margin-bottom: 12px;[m
[32m+[m[32m    text-align: center;[m
[32m+[m[32m    background-color: #DBEAFE; /* blue-100 */[m
[32m+[m[32m    color: #1E3A8A; /* blue-900 */[m
[32m+[m[32m    transition: background-color 0.2s, color 0.2s;[m
[32m+[m[32m    cursor: pointer;[m
[32m+[m[32m    border: none;[m
[32m+[m[32m    font-size: 14px;[m
[32m+[m[32m    display: flex;[m
[32m+[m[32m    align-items: center;[m
[32m+[m[32m    justify-content: center;[m
[32m+[m[32m  }[m
[32m+[m[41m  [m
[32m+[m[32m  .nav-item:hover {[m
[32m+[m[32m    background-color: #BFDBFE; /* blue-200 */[m
[32m+[m[32m  }[m
[32m+[m[41m  [m
[32m+[m[32m  .nav-item.active {[m
[32m+[m[32m    background-color: #3B82F6; /* blue-500 */[m
[32m+[m[32m    color: white;[m
[32m+[m[32m  }[m
[32m+[m[41m  [m
[32m+[m[32m  .info-icon {[m
[32m+[m[32m    display: inline-flex;[m
[32m+[m[32m    align-items: center;[m
[32m+[m[32m    justify-content: center;[m
[32m+[m[32m    width: 16px;[m
[32m+[m[32m    height: 16px;[m
[32m+[m[32m    margin-left: 4px;[m
[32m+[m[32m    font-size: 12px;[m
[32m+[m[32m    color: white;[m
[32m+[m[32m    background-color: #2563EB; /* blue-600 */[m
[32m+[m[32m    border-radius: 50%;[m
[32m+[m[32m  }[m
\ No newline at end of file[m
[1mdiff --git a/frontend_LHB3/src/components/UserNavbar.jsx b/frontend_LHB3/src/components/UserNavbar.jsx[m
[1mnew file mode 100644[m
[1mindex 0000000..fc48c69[m
[1m--- /dev/null[m
[1m+++ b/frontend_LHB3/src/components/UserNavbar.jsx[m
[36m@@ -0,0 +1,31 @@[m
[32m+[m[32mimport React from 'react';[m
[32m+[m[32mimport './UserNavbar.css';[m
[32m+[m
[32m+[m[32mconst UserNavbar = ({ onNavigate, currentPath }) => {[m
[32m+[m[32m  // Map of navigation items to their respective routes[m
[32m+[m[32m  const navItems = [[m
[32m+[m[32m    { name: 'New', path: '/request_booking' },[m
[32m+[m[32m    { name: 'Live Schedule', path: '/live_schedule' },[m
[32m+[m[32m    { name: 'History', path: '/history' }, // Changed from '/' to '/history'[m
[32m+[m[32m    { name: 'Status', path: '/status' },[m
[32m+[m[32m    { name: 'Feedback', path: '/feedback' },[m
[32m+[m[32m    { name: 'Help', path: '/help' },[m
[32m+[m[32m  ];[m
[32m+[m
[32m+[m[32m  return ([m
[32m+[m[32m    <div className="user-navbar">[m
[32m+[m[32m      {navItems.map((item) => ([m
[32m+[m[32m        <button[m
[32m+[m[32m          key={item.name}[m
[32m+[m[32m          onClick={() => onNavigate(item.path)}[m
[32m+[m[32m          className={`nav-item ${currentPath === item.path ? 'active' : ''}`}[m
[32m+[m[32m        >[m
[32m+[m[32m          {item.name}[m
[32m+[m[32m          {item.name === 'New' && <span className="info-icon">ⓘ</span>}[m
[32m+[m[32m        </button>[m
[32m+[m[32m      ))}[m
[32m+[m[32m    </div>[m
[32m+[m[32m  );[m
[32m+[m[32m};[m
[32m+[m
[32m+[m[32mexport default UserNavbar;[m
[1mdiff --git a/frontend_LHB3/src/index.css b/frontend_LHB3/src/index.css[m
[1mnew file mode 100644[m
[1mindex 0000000..a461c50[m
[1m--- /dev/null[m
[1m+++ b/frontend_LHB3/src/index.css[m
[36m@@ -0,0 +1 @@[m
[32m+[m[32m@import "tailwindcss";[m
\ No newline at end of file[m
[1mdiff --git a/frontend_LHB3/src/main.jsx b/frontend_LHB3/src/main.jsx[m
[1mnew file mode 100644[m
[1mindex 0000000..8ba8d53[m
[1m--- /dev/null[m
[1m+++ b/frontend_LHB3/src/main.jsx[m
[36m@@ -0,0 +1,38 @@[m
[32m+[m[32mimport { StrictMode } from 'react'[m
[32m+[m[32mimport { createRoot } from 'react-dom/client'[m
[32m+[m[32mimport './index.css'[m
[32m+[m[32mimport App from './App.jsx'[m
[32m+[m[32mimport { BrowserRouter } from 'react-router-dom'[m
[32m+[m
[32m+[m[32m// TODO: Backend Integration Comments:[m
[32m+[m
[32m+[m[32m// 1. Global API Configuration:[m
[32m+[m[32m// - Create src/api/apiClient.js with axios instance[m
[32m+[m[32m// - Configure base URL from environment variables[m
[32m+[m[32m// - Set up global request/response interceptors[m
[32m+[m
[32m+[m[32m// 2. Auth Provider:[m
[32m+[m[32m// - Wrap app with AuthProvider context[m
[32m+[m[32m// - Initialize authentication state on app load[m
[32m+[m[32m// - Check for existing tokens and validate them[m
[32m+[m
[32m+[m[32m// 3. Error Boundary:[m
[32m+[m[32m// - Add global error boundary component[m
[32m+[m[32m// - Implement error logging to backend[m
[32m+[m[32m// - Create fallback UI for crashed components[m
[32m+[m
[32m+[m[32m// 4. Environment Configuration:[m
[32m+[m[32m// - Use .env files for environment-specific settings[m
[32m+[m[32m// - Configure API URLs for development/production[m
[32m+[m[32m// - Set up feature flags if needed[m
[32m+[m
[32m+[m[32m// 5. Performance Monitoring:[m
[32m+[m[32m// - Initialize performance monitoring tools[m
[32m+[m[32m// - Set up API call timing metrics[m
[32m+[m[32m// - Configure error tracking service[m
[32m+[m
[32m+[m[32mcreateRoot(document.getElementById('root')).render([m
[32m+[m[32m  <BrowserRouter>[m
[32m+[m[32m    <App />[m
[32m+[m[32m  </BrowserRouter>,[m
[32m+[m[32m)[m
[1mdiff --git a/frontend_LHB3/src/pages/Adminviewbooking.css b/frontend_LHB3/src/pages/Adminviewbooking.css[m
[1mnew file mode 100644[m
[1mindex 0000000..b570b9d[m
[1m--- /dev/null[m
[1m+++ b/frontend_LHB3/src/pages/Adminviewbooking.css[m
[36m@@ -0,0 +1,211 @@[m
[32m+[m[32m.admin-booking-main {[m
[32m+[m[32m  width: 100%;[m
[32m+[m[32m  height: 100%;[m
[32m+[m[32m  background-color: white;[m
[32m+[m[32m  border-radius: 8px;[m
[32m+[m[32m  padding: 20px;[m
[32m+[m[32m  box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);[m
[32m+[m[32m}[m
[32m+[m
[32m+[m[32m.admin-date-range-section {[m
[32m+[m[32m  display: flex;[m
[32m+[m[32m  align-items: center;[m
[32m+[m[32m  margin-bottom: 20px;[m
[32m+[m[32m  font-size: 14px;[m
[32m+[m[32m}[m
[32m+[m
[32m+[m[32m.admin-date-selector {[m
[32m+[m[32m  display: flex;[m
[32m+[m[32m  align-items: center;[m
[32m+[m[32m  cursor: pointer;[m
[32m+[m[32m  padding: 8px;[m
[32m+[m[32m  border-radius: 4px;[m
[32m+[m[32m}[m
[32m+[m
[32m+[m[32m.admin-date-selector:hover {[m
[32m+[m[32m  background-color: #f0f0f0;[m
[32m+[m[32m}[m
[32m+[m
[32m+[m[32m.admin-dropdown-arrow {[m
[32m+[m[32m  margin-left: 5px;[m
[32m+[m[32m  font-size: 12px;[m
[32m+[m[32m}[m
[32m+[m
[32m+[m[32m.admin-date-separator {[m
[32m+[m[32m  margin: 0 10px;[m
[32m+[m[32m}[m
[32m+[m
[32m+[m[32m.admin-filter-section {[m
[32m+[m[32m  display: flex;[m
[32m+[m[32m  margin-bottom: 20px;[m
[32m+[m[32m  gap: 10px;[m
[32m+[m[32m}[m
[32m+[m
[32m+[m[32m.admin-filter-dropdown {[m
[32m+[m[32m  display: flex;[m
[32m+[m[32m  align-items: center;[m
[32m+[m[32m  padding: 8px 15px;[m
[32m+[m[32m  background-color: white;[m
[32m+[m[32m  border: 1px solid #ddd;[m
[32m+[m[32m  border-radius: 4px;[m
[32m+[m[32m  cursor: pointer;[m
[32m+[m[32m}[m
[32m+[m
[32m+[m[32m.admin-search-input {[m
[32m+[m[32m  flex: 1;[m
[32m+[m[32m  padding: 8px 15px;[m
[32m+[m[32m  border: 1px solid #ddd;[m
[32m+[m[32m  border-radius: 4px;[m
[32m+[m[32m  font-size: 14px;[m
[32m+[m[32m}[m
[32m+[m
[32m+[m[32m.admin-date-header {[m
[32m+[m[32m  font-size: 16px;[m
[32m+[m[32m  color: #1a73e8;[m
[32m+[m[32m  margin-bottom: 15px;[m
[32m+[m[32m}[m
[32m+[m
[32m+[m[32m.admin-bookings-list {[m
[32m+[m[32m  margin-top: 20px;[m
[32m+[m[32m}[m
[32m+[m
[32m+[m[32m/* Updated booking item layout */[m
[32m+[m[32m.admin-booking-item {[m
[32m+[m[32m  display: flex;[m
[32m+[m[32m  margin-bottom: 15px;[m
[32m+[m[32m  border-radius: 4px;[m
[32m+[m[32m  border: 1px solid #ddd;[m
[32m+[m[32m  position: relative;[m
[32m+[m[32m  flex-wrap: wrap; /* Allow wrapping for smaller screens */[m
[32m+[m[32m}[m
[32m+[m
[32m+[m[32m.admin-booking-item.highlighted {[m
[32m+[m[32m  background-color: #1a73e8;[m
[32m+[m[32m  color: white;[m
[32m+[m[32m}[m
[32m+[m
[32m+[m[32m.admin-time-indicator {[m
[32m+[m[32m  display: flex;[m
[32m+[m[32m  align-items: center;[m
[32m+[m[32m  padding: 10px;[m
[32m+[m[32m  min-width: 180px;[m
[32m+[m[32m}[m
[32m+[m
[32m+[m[32m.admin-blue-dot {[m
[32m+[m[32m  width: 12px;[m
[32m+[m[32m  height: 12px;[m
[32m+[m[32m  background-color: #1a73e8;[m
[32m+[m[32m  border-radius: 50%;[m
[32m+[m[32m  margin-right: 10px;[m
[32m+[m[32m}[m
[32m+[m
[32m+[m[32m.admin-booking-item.highlighted .admin-blue-dot {[m
[32m+[m[32m  background-color: white;[m
[32m+[m[32m}[m
[32m+[m
[32m+[m[32m.admin-time-text {[m
[32m+[m[32m  display: flex;[m
[32m+[m[32m  flex-direction: column;[m
[32m+[m[32m}[m
[32m+[m
[32m+[m[32m.admin-duration {[m
[32m+[m[32m  font-size: 12px;[m
[32m+[m[32m  color: #666;[m
[32m+[m[32m}[m
[32m+[m
[32m+[m[32m.admin-booking-item.highlighted .admin-duration {[m
[32m+[m[32m  color: #e0e0e0;[m
[32m+[m[32m}[m
[32m+[m
[32m+[m[32m/* Split the booking details and actions */[m
[32m+[m[32m.admin-booking-info {[m
[32m+[m[32m  display: flex;[m
[32m+[m[32m  flex: 1;[m
[32m+[m[32m  padding: 10px;[m
[32m+[m[32m  align-items: center;[m
[32m+[m[32m  justify-content: space-between;[m
[32m+[m[32m}[m
[32m+[m
[32m+[m[32m.admin-booking-item.highlighted .admin-booking-info {[m
[32m+[m[32m  background-color: #1a73e8;[m
[32m+[m[32m}[m
[32m+[m
[32m+[m[32m.admin-room-info,[m
[32m+[m[32m.admin-professor-info,[m
[32m+[m[32m.admin-course-info {[m
[32m+[m[32m  flex: 1;[m
[32m+[m[32m  padding: 0 10px;[m
[32m+[m[32m}[m
[32m+[m
[32m+[m[32m/* Improved booking actions styling */[m
[32m+[m[32m.admin-booking-actions {[m
[32m+[m[32m  padding: 10px;[m
[32m+[m[32m  position: relative;[m
[32m+[m[32m  display: flex;[m
[32m+[m[32m  align-items: center;[m
[32m+[m[32m}[m
[32m+[m
[32m+[m[32m.admin-manage-btn {[m
[32m+[m[32m  background-color: transparent;[m
[32m+[m[32m  border: none;[m
[32m+[m[32m  display: flex;[m
[32m+[m[32m  align-items: center;[m
[32m+[m[32m  cursor: pointer;[m
[32m+[m[32m  padding: 5px 10px;[m
[32m+[m[32m  color: inherit;[m
[32m+[m[32m}[m
[32m+[m
[32m+[m[32m/* Fixed dropdown positioning */[m
[32m+[m[32m.admin-dropdown-menu {[m
[32m+[m[32m  position: absolute;[m
[32m+[m[32m  right: 0;[m
[32m+[m[32m  top: calc(100% + 5px); /* Position below the button */[m
[32m+[m[32m  width: 200px;[m
[32m+[m[32m  background-color: white;[m
[32m+[m[32m  border: 1px solid #ddd;[m
[32m+[m[32m  border-radius: 4px;[m
[32m+[m[32m  box-shadow: 0 4px 12px rgba(0, 0, 0, 0.15);[m
[32m+[m[32m  z-index: 1000; /* High z-index to ensure it's on top */[m
[32m+[m[32m  color: #333; /* Reset text color for dropdown items */[m
[32m+[m[32m}[m
[32m+[m
[32m+[m[32m.admin-dropdown-item {[m
[32m+[m[32m  display: flex;[m
[32m+[m[32m  align-items: center;[m
[32m+[m[32m  padding: 10px 15px;[m
[32m+[m[32m  border: none;[m
[32m+[m[32m  background-color: transparent;[m
[32m+[m[32m  width: 100%;[m
[32m+[m[32m  text-align: left;[m
[32m+[m[32m  cursor: pointer;[m
[32m+[m[32m}[m
[32m+[m
[32m+[m[32m.admin-dropdown-item:hover {[m
[32m+[m[32m  background-color: #f5f5f5;[m
[32m+[m[32m}[m
[32m+[m
[32m+[m[32m.admin-dropdown-item .admin-icon {[m
[32m+[m[32m  margin-right: 10px;[m
[32m+[m[32m}[m
[32m+[m
[32m+[m[32m.admin-dropdown-item .admin-trash {[m
[32m+[m[32m  color: #d32f2f;[m
[32m+[m[32m}[m
[32m+[m
[32m+[m[32m/* Media queries for responsiveness */[m
[32m+[m[32m@media (max-width: 768px) {[m
[32m+[m[32m  .admin-booking-item {[m
[32m+[m[32m    flex-direction: column;[m
[32m+[m[32m  }[m
[32m+[m[41m  [m
[32m+[m[32m  .admin-booking-info {[m
[32m+[m[32m    flex-direction: column;[m
[32m+[m[32m    align-items: flex-start;[m
[32m+[m[32m  }[m
[32m+[m[41m  [m
[32m+[m[32m  .admin-room-info,[m
[32m+[m[32m  .admin-professor-info,[m
[32m+[m[32m  .admin-course-info {[m
[32m+[m[32m    padding: 5px 0;[m
[32m+[m[32m  }[m
[32m+[m[32m}[m
[1mdiff --git a/frontend_LHB3/src/pages/Adminviewbooking.jsx b/frontend_LHB3/src/pages/Adminviewbooking.jsx[m
[1mnew file mode 100644[m
[1mindex 0000000..c2380e2[m
[1m--- /dev/null[m
[1m+++ b/frontend_LHB3/src/pages/Adminviewbooking.jsx[m
[36m@@ -0,0 +1,204 @@[m
[32m+[m[32m// import React, { useState } from 'react';[m
[32m+[m[32m// import './Adminviewbooking.css';[m
[32m+[m
[32m+[m[32m// // TODO: Backend Integration Comments:[m
[32m+[m
[32m+[m[32m// // 1. Admin Data Fetching:[m
[32m+[m[32m// // - Replace mock data with admin API endpoints[m
[32m+[m[32m// // - Create src/api/admin.js for admin-specific functions[m
[32m+[m[32m// // - Call GET /api/admin/bookings with date range parameters[m
[32m+[m[32m// // - Implement proper pagination and filtering[m
[32m+[m
[32m+[m[32m// // 2. Booking Management:[m
[32m+[m[32m// // - Implement view/edit functionality:[m
[32m+[m[32m// //   a) GET /api/admin/bookings/{id} for detailed view[m
[32m+[m[32m// //   b) PUT /api/admin/bookings/{id} for updates[m
[32m+[m[32m// // - Implement deletion with DELETE /api/admin/bookings/{id}[m
[32m+[m[32m// // - Add confirmation dialogs for destructive actions[m
[32m+[m
[32m+[m[32m// // 3. Date Range Selection:[m
[32m+[m[32m// // - Send selected date range to backend[m
[32m+[m[32m// // - Format dates according to API requirements[m
[32m+[m[32m// // - Implement calendar UI for date selection[m
[32m+[m
[32m+[m[32m// // 4. Search and Filtering:[m
[32m+[m[32m// // - Implement server-side search via query parameters[m
[32m+[m[32m// // - Add filters for status, hall, user, etc.[m
[32m+[m[32m// // - Make filtering options dynamic based on available data[m
[32m+[m
[32m+[m[32m// // 5. Bulk Actions:[m
[32m+[m[32m// // - Add functionality for bulk approve/reject/delete[m
[32m+[m[32m// // - Implement POST /api/admin/bookings/bulk with action and IDs[m
[32m+[m
[32m+[m[32m// // 6. Access Control:[m
[32m+[m[32m// // - Verify admin permissions before rendering component[m
[32m+[m[32m// // - Disable actions based on user permissions[m
[32m+[m[32m// // - Handle unauthorized access attempts[m
[32m+[m
[32m+[m[32m// // 7. Audit Logging:[m
[32m+[m[32m// // - Log all admin actions for accountability[m
[32m+[m[32m// // - Display who made changes and when[m
[32m+[m
[32m+[m
[32m+[m[32mimport React, { useState } from 'react';[m
[32m+[m[32mimport './Adminviewbooking.css';[m
[32m+[m
[32m+[m[32mconst Adminviewbooking = () => {[m
[32m+[m[32m  const [dateRange, setDateRange] = useState({[m
[32m+[m[32m    start: 'TUESDAY, JANUARY 21, 2025',[m
[32m+[m[32m    end: 'FRIDAY, MARCH 14, 2025'[m
[32m+[m[32m  });[m
[32m+[m[41m  [m
[32m+[m[32m  const [searchQuery, setSearchQuery] = useState('');[m
[32m+[m[32m  const [openDropdownId, setOpenDropdownId] = useState(null);[m
[32m+[m[41m  [m
[32m+[m[32m  // Sample booking data[m
[32m+[m[32m  const bookings = [[m
[32m+[m[32m    {[m[41m [m
[32m+[m[32m      id: 1,[m[41m [m
[32m+[m[32m      time: '9:30 AM–11:00 AM',[m[41m [m
[32m+[m[32m      duration: '(1h 30m)',[m[41m [m
[32m+[m[32m      room: 'L-20',[m
[32m+[m[32m      professor: 'Pclub',[m
[32m+[m[32m      course: 'Intro to English Language'[m
[32m+[m[32m    },[m
[32m+[m[32m    {[m[41m [m
[32m+[m[32m      id: 2,[m[41m [m
[32m+[m[32m      time: '9:30 AM–10:15 AM',[m[41m [m
[32m+[m[32m      duration: '(45m)',[m[41m [m
[32m+[m[32m      room: 'LH3',[m
[32m+[m[32m      professor: '(Prof A)',[m
[32m+[m[32m      course: 'CS202'[m
[32m+[m[32m    },[m
[32m+[m[32m    {[m[41m [m
[32m+[m[32m      id: 3,[m[41m [m
[32m+[m[32m      time: '11:00 AM–12:00 PM',[m[41m [m
[32m+[m[32m      duration: '(1h)',[m[41m [m
[32m+[m[32m      room: 'LH8',[m
[32m+[m[32m      professor: '(Prof B)',[m
[32m+[m[32m      course: 'CS771'[m
[32m+[m[32m    },[m
[32m+[m[32m    {[m[41m [m
[32m+[m[32m      id: 4,[m[41m [m
[32m+[m[32m      time: '11:00 AM–12:00 PM',[m[41m [m
[32m+[m[32m      duration: '(1h)',[m[41m [m
[32m+[m[32m      room: 'LH2',[m
[32m+[m[32m      professor: '(Prof C)',[m
[32m+[m[32m      course: 'MTH112 QUIZ'[m
[32m+[m[32m    },[m
[32m+[m[32m    {[m[41m [m
[32m+[m[32m      id: 5,[m[41m [m
[32m+[m[32m      time: '11:45 AM–12:45 PM',[m[41m [m
[32m+[m[32m      duration: '(1h)',[m[41m [m
[32m+[m[32m      room: 'LH1',[m
[32m+[m[32m      professor: '(Prof D)',[m
[32m+[m[32m      course: 'CS253'[m
[32m+[m[32m    }[m
[32m+[m[32m  ];[m
[32m+[m
[32m+[m[32m  const toggleDropdown = (id) => {[m
[32m+[m[32m    setOpenDropdownId(openDropdownId === id ? null : id);[m
[32m+[m[32m  };[m
[32m+[m
[32m+[m[32m  const handleSearch = (e) => {[m
[32m+[m[32m    setSearchQuery(e.target.value);[m
[32m+[m[32m  };[m
[32m+[m
[32m+[m[32m  const handleViewDetails = (id) => {[m
[32m+[m[32m    console.log(`View/edit details for booking ${id}`);[m
[32m+[m[32m    setOpenDropdownId(null);[m
[32m+[m[32m  };[m
[32m+[m
[32m+[m[32m  const handleRemoveBooking = (id) => {[m
[32m+[m[32m    console.log(`Remove booking ${id}`);[m
[32m+[m[32m    setOpenDropdownId(null);[m
[32m+[m[32m  };[m
[32m+[m
[32m+[m[32m  // Close dropdown when clicking outside[m
[32m+[m[32m  React.useEffect(() => {[m
[32m+[m[32m    const handleClickOutside = (event) => {[m
[32m+[m[32m      if (openDropdownId && !event.target.closest('.admin-booking-actions')) {[m
[32m+[m[32m        setOpenDropdownId(null);[m
[32m+[m[32m      }[m
[32m+[m[32m    };[m
[32m+[m
[32m+[m[32m    document.addEventListener('mousedown', handleClickOutside);[m
[32m+[m[32m    return () => {[m
[32m+[m[32m      document.removeEventListener('mousedown', handleClickOutside);[m
[32m+[m[32m    };[m
[32m+[m[32m  }, [openDropdownId]);[m
[32m+[m
[32m+[m[32m  return ([m
[32m+[m[32m    <div className="admin-booking-main">[m
[32m+[m[32m      <div className="admin-date-range-section">[m
[32m+[m[32m        <div className="admin-date-selector">[m
[32m+[m[32m          <span>{dateRange.start}</span>[m
[32m+[m[32m          <span className="admin-dropdown-arrow">▼</span>[m
[32m+[m[32m        </div>[m
[32m+[m[32m        <span className="admin-date-separator">–</span>[m
[32m+[m[32m        <div className="admin-date-selector">[m
[32m+[m[32m          <span>{dateRange.end}</span>[m
[32m+[m[32m          <span className="admin-dropdown-arrow">▼</span>[m
[32m+[m[32m        </div>[m
[32m+[m[32m      </div>[m
[32m+[m
[32m+[m[32m      <div className="admin-filter-section">[m
[32m+[m[32m        <div className="admin-filter-dropdown">[m
[32m+[m[32m          <span>Filter</span>[m
[32m+[m[32m          <span className="admin-dropdown-arrow">▼</span>[m
[32m+[m[32m        </div>[m
[32m+[m[32m        <input[m[41m [m
[32m+[m[32m          type="text"[m[41m [m
[32m+[m[32m          placeholder="Search..."[m[41m [m
[32m+[m[32m          className="admin-search-input"[m
[32m+[m[32m          value={searchQuery}[m
[32m+[m[32m          onChange={handleSearch}[m
[32m+[m[32m        />[m
[32m+[m[32m      </div>[m
[32m+[m
[32m+[m[32m      <div className="admin-bookings-list">[m
[32m+[m[32m        <h2 className="admin-date-header">{dateRange.start}</h2>[m
[32m+[m[41m        [m
[32m+[m[32m        {bookings.map((booking) => ([m
[32m+[m[32m          <div key={booking.id} className={`admin-booking-item ${booking.id === 1 ? 'highlighted' : ''}`}>[m
[32m+[m[32m            <div className="admin-time-indicator">[m
[32m+[m[32m              <div className="admin-blue-dot"></div>[m
[32m+[m[32m              <div className="admin-time-text">[m
[32m+[m[32m                <span>{booking.time}</span>[m
[32m+[m[32m                <span className="admin-duration">{booking.duration}</span>[m
[32m+[m[32m              </div>[m
[32m+[m[32m            </div>[m
[32m+[m[41m            [m
[32m+[m[32m            <div className="admin-booking-info">[m
[32m+[m[32m              <div className="admin-room-info">{booking.room}</div>[m
[32m+[m[32m              <div className="admin-professor-info">{booking.professor}</div>[m
[32m+[m[32m              <div className="admin-course-info">{booking.course}</div>[m
[32m+[m[32m            </div>[m
[32m+[m[41m            [m
[32m+[m[32m            <div className="admin-booking-actions">[m
[32m+[m[32m              <button[m[41m [m
[32m+[m[32m                className="admin-manage-btn"[m[41m [m
[32m+[m[32m                onClick={() => toggleDropdown(booking.id)}[m
[32m+[m[32m              >[m
[32m+[m[32m                Manage <span className="admin-dropdown-arrow">▼</span>[m
[32m+[m[32m              </button>[m
[32m+[m[41m              [m
[32m+[m[32m              {openDropdownId === booking.id && ([m
[32m+[m[32m                <div className="admin-dropdown-menu">[m
[32m+[m[32m                  <button onClick={() => handleViewDetails(booking.id)} className="admin-dropdown-item">[m
[32m+[m[32m                    <span className="admin-icon">✎</span> View/edit details[m
[32m+[m[32m                  </button>[m
[32m+[m[32m                  <button onClick={() => handleRemoveBooking(booking.id)} className="admin-dropdown-item">[m
[32m+[m[32m                    <span className="admin-icon admin-trash">🗑</span> Remove booking[m
[32m+[m[32m                  </button>[m
[32m+[m[32m                </div>[m
[32m+[m[32m              )}[m
[32m+[m[32m            </div>[m
[32m+[m[32m          </div>[m
[32m+[m[32m        ))}[m
[32m+[m[32m      </div>[m
[32m+[m[32m    </div>[m
[32m+[m[32m  );[m
[32m+[m[32m};[m
[32m+[m
[32m+[m[32mexport default Adminviewbooking;[m
[1mdiff --git a/frontend_LHB3/src/pages/CreateUser.css b/frontend_LHB3/src/pages/CreateUser.css[m
[1mnew file mode 100644[m
[1mindex 0000000..1d372d7[m
[1m--- /dev/null[m
[1m+++ b/frontend_LHB3/src/pages/CreateUser.css[m
[36m@@ -0,0 +1,454 @@[m
[32m+[m[32m/* .create-user-container {[m
[32m+[m[32m    background-color: #fff;[m
[32m+[m[32m    border-radius: 8px;[m
[32m+[m[32m    width: 100%;[m
[32m+[m[32m    padding: 20px;[m
[32m+[m[32m  }[m
[32m+[m[41m  [m
[32m+[m[32m  .create-user-header {[m
[32m+[m[32m    display: flex;[m
[32m+[m[32m    justify-content: space-between;[m
[32m+[m[32m    align-items: center;[m
[32m+[m[32m    margin-bottom: 20px;[m
[32m+[m[32m    padding-bottom: 15px;[m
[32m+[m[32m    border-bottom: 1px solid #e1e1e1;[m
[32m+[m[32m  }[m
[32m+[m[41m  [m
[32m+[m[32m  .create-user-header h2 {[m
[32m+[m[32m    margin: 0;[m
[32m+[m[32m    font-size: 18px;[m
[32m+[m[32m    color: #333;[m
[32m+[m[32m  }[m
[32m+[m[41m  [m
[32m+[m[32m  .user-type-indicator {[m
[32m+[m[32m    display: flex;[m
[32m+[m[32m    align-items: center;[m
[32m+[m[32m    background-color: #e6f0ff;[m
[32m+[m[32m    padding: 8px 15px;[m
[32m+[m[32m    border-radius: 5px;[m
[32m+[m[32m    gap: 10px;[m
[32m+[m[32m  }[m
[32m+[m[41m  [m
[32m+[m[32m  .user-icon {[m
[32m+[m[32m    display: flex;[m
[32m+[m[32m    align-items: center;[m
[32m+[m[32m    justify-content: center;[m
[32m+[m[32m    color: #3366cc;[m
[32m+[m[32m  }[m
[32m+[m[41m  [m
[32m+[m[32m  .create-user-form {[m
[32m+[m[32m    display: flex;[m
[32m+[m[32m    flex-direction: column;[m
[32m+[m[32m    gap: 20px;[m
[32m+[m[32m  }[m
[32m+[m[41m  [m
[32m+[m[32m  .form-row {[m
[32m+[m[32m    display: flex;[m
[32m+[m[32m    gap: 20px;[m
[32m+[m[32m  }[m
[32m+[m[41m  [m
[32m+[m[32m  .form-group {[m
[32m+[m[32m    display: flex;[m
[32m+[m[32m    flex-direction: column;[m
[32m+[m[32m    flex: 1;[m
[32m+[m[32m  }[m
[32m+[m[41m  [m
[32m+[m[32m  .form-group label {[m
[32m+[m[32m    margin-bottom: 8px;[m
[32m+[m[32m    font-weight: 500;[m
[32m+[m[32m    color: #333;[m
[32m+[m[32m  }[m
[32m+[m[41m  [m
[32m+[m[32m  .required-label::after {[m
[32m+[m[32m    content: " *";[m
[32m+[m[32m    color: red;[m
[32m+[m[32m  }[m
[32m+[m[41m  [m
[32m+[m[32m  .form-group input[type="text"],[m
[32m+[m[32m  .form-group input[type="password"],[m
[32m+[m[32m  .form-group input[type="email"] {[m
[32m+[m[32m    padding: 10px;[m
[32m+[m[32m    border: 1px solid #ddd;[m
[32m+[m[32m    border-radius: 5px;[m
[32m+[m[32m    font-size: 14px;[m
[32m+[m[32m  }[m
[32m+[m[41m  [m
[32m+[m[32m  .form-group input:focus {[m
[32m+[m[32m    outline: none;[m
[32m+[m[32m    border-color: #3366cc;[m
[32m+[m[32m  }[m
[32m+[m[41m  [m
[32m+[m[32m  .radio-options {[m
[32m+[m[32m    display: flex;[m
[32m+[m[32m    flex-direction: column;[m
[32m+[m[32m    gap: 12px;[m
[32m+[m[32m  }[m
[32m+[m[41m  [m
[32m+[m[32m  .radio-option {[m
[32m+[m[32m    display: flex;[m
[32m+[m[32m    align-items: center;[m
[32m+[m[32m    gap: 8px;[m
[32m+[m[32m  }[m
[32m+[m[41m  [m
[32m+[m[32m  .radio-option input[type="radio"] {[m
[32m+[m[32m    cursor: pointer;[m
[32m+[m[32m  }[m
[32m+[m[41m  [m
[32m+[m[32m  .radio-option label {[m
[32m+[m[32m    margin: 0;[m
[32m+[m[32m    cursor: pointer;[m
[32m+[m[32m  }[m
[32m+[m[41m  [m
[32m+[m[32m  .categories-row {[m
[32m+[m[32m    align-items: flex-start;[m
[32m+[m[32m  }[m
[32m+[m[41m  [m
[32m+[m[32m  .category-group, .authority-group {[m
[32m+[m[32m    background-color: #f5f5f5;[m
[32m+[m[32m    padding: 15px;[m
[32m+[m[32m    border-radius: 5px;[m
[32m+[m[32m  }[m
[32m+[m[41m  [m
[32m+[m[32m  .authority-header {[m
[32m+[m[32m    display: flex;[m
[32m+[m[32m    justify-content: space-between;[m
[32m+[m[32m    align-items: center;[m
[32m+[m[32m    margin-bottom: 10px;[m
[32m+[m[32m  }[m
[32m+[m[41m  [m
[32m+[m[32m  .add-button {[m
[32m+[m[32m    display: flex;[m
[32m+[m[32m    align-items: center;[m
[32m+[m[32m    gap: 5px;[m
[32m+[m[32m    background: none;[m
[32m+[m[32m    border: none;[m
[32m+[m[32m    color: #3366cc;[m
[32m+[m[32m    cursor: pointer;[m
[32m+[m[32m    font-size: 14px;[m
[32m+[m[32m  }[m
[32m+[m[41m  [m
[32m+[m[32m  .add-button:hover {[m
[32m+[m[32m    text-decoration: underline;[m
[32m+[m[32m  }[m
[32m+[m[41m  [m
[32m+[m[32m  .form-actions {[m
[32m+[m[32m    display: flex;[m
[32m+[m[32m    justify-content: flex-end;[m
[32m+[m[32m    margin-top: 20px;[m
[32m+[m[32m  }[m
[32m+[m[41m  [m
[32m+[m[32m  .confirm-button {[m
[32m+[m[32m    background-color: #b3d1ff;[m
[32m+[m[32m    color: #333;[m
[32m+[m[32m    border: none;[m
[32m+[m[32m    padding: 10px 20px;[m
[32m+[m[32m    border-radius: 5px;[m
[32m+[m[32m    font-weight: 500;[m
[32m+[m[32m    cursor: pointer;[m
[32m+[m[32m    transition: background-color 0.3s;[m
[32m+[m[32m  }[m
[32m+[m[41m  [m
[32m+[m[32m  .confirm-button:hover {[m
[32m+[m[32m    background-color: #99c2ff;[m
[32m+[m[32m  }[m
[32m+[m[41m  [m
[32m+[m[32m  /* Responsive adjustments */[m
[32m+[m[32m  /* @media (max-width: 768px) {[m
[32m+[m[32m    .form-row {[m
[32m+[m[32m      flex-direction: column;[m
[32m+[m[32m    }[m
[32m+[m[41m    [m
[32m+[m[32m    .remarks {[m
[32m+[m[32m      margin-top: 15px;[m
[32m+[m[32m    }[m
[32m+[m[32m  } */ */[m
[32m+[m
[32m+[m
[32m+[m
[32m+[m
[32m+[m
[32m+[m
[32m+[m[32m  /* CreateUser.css */[m
[32m+[m
[32m+[m[32m.create-user-container {[m
[32m+[m[32m  background-color: #fff;[m
[32m+[m[32m  border-radius: 8px;[m
[32m+[m[32m  width: 100%;[m
[32m+[m[32m  padding: 20px;[m
[32m+[m[32m  box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);[m
[32m+[m[32m}[m
[32m+[m
[32m+[m[32m.create-user-header {[m
[32m+[m[32m  display: flex;[m
[32m+[m[32m  justify-content: space-between;[m
[32m+[m[32m  align-items: center;[m
[32m+[m[32m  margin-bottom: 20px;[m
[32m+[m[32m  padding-bottom: 15px;[m
[32m+[m[32m  border-bottom: 1px solid #e1e1e1;[m
[32m+[m[32m}[m
[32m+[m
[32m+[m[32m.create-user-header h2 {[m
[32m+[m[32m  margin: 0;[m
[32m+[m[32m  font-size: 18px;[m
[32m+[m[32m  color: #333;[m
[32m+[m[32m}[m
[32m+[m
[32m+[m[32m.user-type-indicator {[m
[32m+[m[32m  display: flex;[m
[32m+[m[32m  align-items: center;[m
[32m+[m[32m  background-color: #e6f0ff;[m
[32m+[m[32m  padding: 8px 15px;[m
[32m+[m[32m  border-radius: 5px;[m
[32m+[m[32m  gap: 10px;[m
[32m+[m[32m}[m
[32m+[m
[32m+[m[32m.user-icon {[m
[32m+[m[32m  display: flex;[m
[32m+[m[32m  align-items: center;[m
[32m+[m[32m  justify-content: center;[m
[32m+[m[32m  color: #3366cc;[m
[32m+[m[32m}[m
[32m+[m
[32m+[m[32m.create-user-form {[m
[32m+[m[32m  display: flex;[m
[32m+[m[32m  flex-direction: column;[m
[32m+[m[32m  gap: 20px;[m
[32m+[m[32m}[m
[32m+[m
[32m+[m[32m.form-row {[m
[32m+[m[32m  display: flex;[m
[32m+[m[32m  gap: 20px;[m
[32m+[m[32m}[m
[32m+[m
[32m+[m[32m.form-group {[m
[32m+[m[32m  display: flex;[m
[32m+[m[32m  flex-direction: column;[m
[32m+[m[32m  flex: 1;[m
[32m+[m[32m}[m
[32m+[m
[32m+[m[32m.form-group label {[m
[32m+[m[32m  margin-bottom: 8px;[m
[32m+[m[32m  font-weight: 500;[m
[32m+[m[32m  color: #333;[m
[32m+[m[32m}[m
[32m+[m
[32m+[m[32m.required-label::after {[m
[32m+[m[32m  content: " *";[m
[32m+[m[32m  color: red;[m
[32m+[m[32m}[m
[32m+[m
[32m+[m[32m.form-group input[type="text"],[m
[32m+[m[32m.form-group input[type="password"],[m
[32m+[m[32m.form-group input[type="email"] {[m
[32m+[m[32m  padding: 10px;[m
[32m+[m[32m  border: 1px solid #ddd;[m
[32m+[m[32m  border-radius: 5px;[m
[32m+[m[32m  font-size: 14px;[m
[32m+[m[32m}[m
[32m+[m
[32m+[m[32m.form-group input:focus {[m
[32m+[m[32m  outline: none;[m
[32m+[m[32m  border-color: #3366cc;[m
[32m+[m[32m}[m
[32m+[m
[32m+[m[32m.radio-options {[m
[32m+[m[32m  display: flex;[m
[32m+[m[32m  flex-direction: column;[m
[32m+[m[32m  gap: 12px;[m
[32m+[m[32m}[m
[32m+[m
[32m+[m[32m.radio-option {[m
[32m+[m[32m  display: flex;[m
[32m+[m[32m  align-items: center;[m
[32m+[m[32m  gap: 8px;[m
[32m+[m[32m}[m
[32m+[m
[32m+[m[32m.radio-option input[type="radio"] {[m
[32m+[m[32m  cursor: pointer;[m
[32m+[m[32m}[m
[32m+[m
[32m+[m[32m.radio-option label {[m
[32m+[m[32m  margin: 0;[m
[32m+[m[32m  cursor: pointer;[m
[32m+[m[32m}[m
[32m+[m
[32m+[m[32m.categories-row {[m
[32m+[m[32m  align-items: flex-start;[m
[32m+[m[32m}[m
[32m+[m
[32m+[m[32m.category-group,[m
[32m+[m[32m.authority-group {[m
[32m+[m[32m  background-color: #f5f5f5;[m
[32m+[m[32m  padding: 15px;[m
[32m+[m[32m  border-radius: 5px;[m
[32m+[m[32m}[m
[32m+[m
[32m+[m[32m.authority-header {[m
[32m+[m[32m  display: flex;[m
[32m+[m[32m  justify-content: space-between;[m
[32m+[m[32m  align-items: center;[m
[32m+[m[32m  margin-bottom: 10px;[m
[32m+[m[32m}[m
[32m+[m
[32m+[m[32m.add-button {[m
[32m+[m[32m  display: flex;[m
[32m+[m[32m  align-items: center;[m
[32m+[m[32m  gap: 5px;[m
[32m+[m[32m  background: none;[m
[32m+[m[32m  border: none;[m
[32m+[m[32m  color: #3366cc;[m
[32m+[m[32m  cursor: pointer;[m
[32m+[m[32m  font-size: 14px;[m
[32m+[m[32m}[m
[32m+[m
[32m+[m[32m.add-button:hover {[m
[32m+[m[32m  text-decoration: underline;[m
[32m+[m[32m}[m
[32m+[m
[32m+[m[32m/* New Authority Form */[m
[32m+[m[32m.new-authority-form {[m
[32m+[m[32m  background-color: #f9f9f9;[m
[32m+[m[32m  padding: 15px;[m
[32m+[m[32m  border-radius: 5px;[m
[32m+[m[32m  margin-bottom: 15px;[m
[32m+[m[32m  border: 1px solid #e1e1e1;[m
[32m+[m[32m}[m
[32m+[m
[32m+[m[32m.new-authority-form h4 {[m
[32m+[m[32m  margin-top: 0;[m
[32m+[m[32m  margin-bottom: 15px;[m
[32m+[m[32m  font-size: 16px;[m
[32m+[m[32m  color: #333;[m
[32m+[m[32m}[m
[32m+[m
[32m+[m[32m.add-authority-button {[m
[32m+[m[32m  background-color: #3366cc;[m
[32m+[m[32m  color: white;[m
[32m+[m[32m  border: none;[m
[32m+[m[32m  padding: 8px 15px;[m
[32m+[m[32m  border-radius: 4px;[m
[32m+[m[32m  cursor: pointer;[m
[32m+[m[32m  margin-top: 10px;[m
[32m+[m[32m}[m
[32m+[m
[32m+[m[32m.add-authority-button:hover {[m
[32m+[m[32m  background-color: #2855b3;[m
[32m+[m[32m}[m
[32m+[m
[32m+[m[32m/* Authority Selector */[m
[32m+[m[32m.authority-selector {[m
[32m+[m[32m  border: 1px solid #ddd;[m
[32m+[m[32m  border-radius: 5px;[m
[32m+[m[32m  padding: 10px;[m
[32m+[m[32m  background-color: #fff;[m
[32m+[m[32m}[m
[32m+[m
[32m+[m[32m.selected-authorities {[m
[32m+[m[32m  display: flex;[m
[32m+[m[32m  flex-wrap: wrap;[m
[32m+[m[32m  gap: 8px;[m
[32m+[m[32m  margin-bottom: 10px;[m
[32m+[m[32m}[m
[32m+[m
[32m+[m[32m.selected-authority {[m
[32m+[m[32m  display: flex;[m
[32m+[m[32m  align-items: center;[m
[32m+[m[32m  background-color: #e6f0ff;[m
[32m+[m[32m  padding: 5px 10px;[m
[32m+[m[32m  border-radius: 4px;[m
[32m+[m[32m  font-size: 14px;[m
[32m+[m[32m  gap: 8px;[m
[32m+[m[32m}[m
[32m+[m
[32m+[m[32m.remove-authority {[m
[32m+[m[32m  background: none;[m
[32m+[m[32m  border: none;[m
[32m+[m[32m  color: #666;[m
[32m+[m[32m  cursor: pointer;[m
[32m+[m[32m  font-size: 16px;[m
[32m+[m[32m  display: flex;[m
[32m+[m[32m  align-items: center;[m
[32m+[m[32m  justify-content: center;[m
[32m+[m[32m  padding: 0;[m
[32m+[m[32m  width: 20px;[m
[32m+[m[32m  height: 20px;[m
[32m+[m[32m}[m
[32m+[m
[32m+[m[32m.remove-authority:hover {[m
[32m+[m[32m  color: #ff3333;[m
[32m+[m[32m}[m
[32m+[m
[32m+[m[32m.authority-search {[m
[32m+[m[32m  position: relative;[m
[32m+[m[32m}[m
[32m+[m
[32m+[m[32m.authority-search input {[m
[32m+[m[32m  width: 100%;[m
[32m+[m[32m  padding: 10px;[m
[32m+[m[32m  border: 1px solid #ddd;[m
[32m+[m[32m  border-radius: 5px;[m
[32m+[m[32m  font-size: 14px;[m
[32m+[m[32m}[m
[32m+[m
[32m+[m[32m.authority-dropdown {[m
[32m+[m[32m  position: absolute;[m
[32m+[m[32m  top: 100%;[m
[32m+[m[32m  left: 0;[m
[32m+[m[32m  right: 0;[m
[32m+[m[32m  background-color: white;[m
[32m+[m[32m  border: 1px solid #ddd;[m
[32m+[m[32m  border-radius: 0 0 5px 5px;[m
[32m+[m[32m  max-height: 200px;[m
[32m+[m[32m  overflow-y: auto;[m
[32m+[m[32m  z-index: 10;[m
[32m+[m[32m  box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);[m
[32m+[m[32m}[m
[32m+[m
[32m+[m[32m.authority-option {[m
[32m+[m[32m  padding: 8px 10px;[m
[32m+[m[32m  cursor: pointer;[m
[32m+[m[32m  transition: background-color 0.2s;[m
[32m+[m[32m}[m
[32m+[m
[32m+[m[32m.authority-option:hover {[m
[32m+[m[32m  background-color: #f0f7ff;[m
[32m+[m[32m}[m
[32m+[m
[32m+[m[32m.no-results {[m
[32m+[m[32m  padding: 10px;[m
[32m+[m[32m  color: #666;[m
[32m+[m[32m  text-align: center;[m
[32m+[m[32m}[m
[32m+[m
[32m+[m[32m.form-actions {[m
[32m+[m[32m  display: flex;[m
[32m+[m[32m  justify-content: flex-end;[m
[32m+[m[32m  margin-top: 20px;[m
[32m+[m[32m}[m
[32m+[m
[32m+[m[32m.confirm-button {[m
[32m+[m[32m  background-color: #b3d1ff;[m
[32m+[m[32m  color: #333;[m
[32m+[m[32m  border: none;[m
[32m+[m[32m  padding: 10px 20px;[m
[32m+[m[32m  border-radius: 5px;[m
[32m+[m[32m  font-weight: 500;[m
[32m+[m[32m  cursor: pointer;[m
[32m+[m[32m  transition: background-color 0.3s;[m
[32m+[m[32m}[m
[32m+[m
[32m+[m[32m.confirm-button:hover {[m
[32m+[m[32m  background-color: #99c2ff;[m
[32m+[m[32m}[m
[32m+[m
[32m+[m[32m/* Responsive adjustments */[m
[32m+[m[32m@media (max-width: 768px) {[m
[32m+[m[32m  .form-row {[m
[32m+[m[32m    flex-direction: column;[m
[32m+[m[32m    gap: 15px;[m
[32m+[m[32m  }[m
[32m+[m[41m  [m
[32m+[m[32m  .remarks {[m
[32m+[m[32m    margin-top: 0;[m
[32m+[m[32m  }[m
[32m+[m[32m}[m
\ No newline at end of file[m
[1mdiff --git a/frontend_LHB3/src/pages/CreateUser.jsx b/frontend_LHB3/src/pages/CreateUser.jsx[m
[1mnew file mode 100644[m
[1mindex 0000000..1a69278[m
[1m--- /dev/null[m
[1m+++ b/frontend_LHB3/src/pages/CreateUser.jsx[m
[36m@@ -0,0 +1,422 @@[m
[32m+[m[32mimport React, { useState, useEffect } from 'react';[m
[32m+[m[32mimport axios from 'axios';[m
[32m+[m[32mimport './CreateUser.css';[m
[32m+[m
[32m+[m[32m// TODO: Backend Integration Comments:[m
[32m+[m
[32m+[m[32m// 1. User Creation API:[m
[32m+[m[32m// - Replace console.log with actual API call[m
[32m+[m[32m// - Create src/api/users.js for user management[m
[32m+[m[32m// - Implement POST /api/admin/users with proper validation[m
[32m+[m[32m// - Handle various response statuses (success, validation error, etc.)[m
[32m+[m
[32m+[m[32m// 2. Authority Management:[m
[32m+[m[32m// - Already partially implemented with axios[m
[32m+[m[32m// - Update endpoints to match your backend structure[m
[32m+[m[32m// - Add proper error handling for authority API calls[m
[32m+[m[32m// - Implement optimistic updates for better UX[m
[32m+[m
[32m+[m[32m// 3. Form Validation:[m
[32m+[m[32m// - Add server-side validation error display[m
[32m+[m[32m// - Implement client-side validation for all fields[m
[32m+[m[32m// - Check for existing users before submission (debounced)[m
[32m+[m
[32m+[m[32m// 4. Security Considerations:[m
[32m+[m[32m// - Ensure password complexity requirements are enforced[m
[32m+[m[32m// - Don't send plaintext passwords in logs/console[m
[32m+[m[32m// - Consider implementing password strength meter[m
[32m+[m
[32m+[m[32m// 5. Success Handling:[m
[32m+[m[32m// - Show success message after user creation[m
[32m+[m[32m// - Provide options to:[m
[32m+[m[32m//   a) Create another user[m
[32m+[m[32m//   b) View the created user[m
[32m+[m[32m//   c) Return to admin dashboard[m
[32m+[m
[32m+[m[32m// 6. Permission Checks:[m
[32m+[m[32m// - Verify admin has permission to create users[m
[32m+[m[32m// - Disable fields based on admin permission level[m
[32m+[m[32m// - Handle unauthorized actions gracefully[m
[32m+[m
[32m+[m[32m// 7. Role-Based Options:[m
[32m+[m[32m// - Fetch available roles from backend[m
[32m+[m[32m// - Dynamically adjust form fields based on selected role[m
[32m+[m[32m// - Show/hide certain options based on user type[m
[32m+[m
[32m+[m[32mconst CreateUser = () => {[m
[32m+[m[32m  const [formData, setFormData] = useState({[m
[32m+[m[32m    userId: '',[m
[32m+[m[32m    password: '',[m
[32m+[m[32m    email: '',[m
[32m+[m[32m    remarks: '',[m
[32m+[m[32m    category: '',[m
[32m+[m[32m    verifyingAuthority: '',[m
[32m+[m[32m    authorities: [] // New field to store selected authority IDs[m
[32m+[m[32m  });[m
[32m+[m
[32m+[m[32m  // New state for authority management[m
[32m+[m[32m  const [availableAuthorities, setAvailableAuthorities] = useState([]);[m
[32m+[m[32m  const [searchTerm, setSearchTerm] = useState('');[m
[32m+[m[32m  const [selectedAuthorities, setSelectedAuthorities] = useState([]);[m
[32m+[m[32m  const [showDropdown, setShowDropdown] = useState(false);[m
[32m+[m[32m  const [newAuthority, setNewAuthority] = useState({ name: '', email: '' });[m
[32m+[m[32m  const [showAuthorityForm, setShowAuthorityForm] = useState(false);[m
[32m+[m
[32m+[m[32m  // Fetch available authorities on component mount[m
[32m+[m[32m  useEffect(() => {[m
[32m+[m[32m    // Replace with your actual API endpoint[m
[32m+[m[32m    axios.get("http://127.0.0.1:8000/api/user/authorities/")[m
[32m+[m[32m      .then(response => setAvailableAuthorities(response.data))[m
[32m+[m[32m      .catch(error => console.error("Error fetching authorities:", error));[m
[32m+[m[32m  }, []);[m
[32m+[m
[32m+[m[32m  // Update formData when selectedAuthorities changes[m
[32m+[m[32m  useEffect(() => {[m
[32m+[m[32m    setFormData(prevState => ({[m
[32m+[m[32m      ...prevState,[m
[32m+[m[32m      authorities: selectedAuthorities.map(auth => auth.id)[m
[32m+[m[32m    }));[m
[32m+[m[32m  }, [selectedAuthorities]);[m
[32m+[m
[32m+[m[32m  // Filter authorities based on search term[m
[32m+[m[32m  const filteredAuthorities = availableAuthorities.filter(auth =>[m[41m [m
[32m+[m[32m    auth.name.toLowerCase().includes(searchTerm.toLowerCase())[m
[32m+[m[32m  );[m
[32m+[m
[32m+[m[32m  const handleChange = (e) => {[m
[32m+[m[32m    const { name, value } = e.target;[m
[32m+[m[32m    setFormData(prevState => ({[m
[32m+[m[32m      ...prevState,[m
[32m+[m[32m      [name]: value[m
[32m+[m[32m    }));[m
[32m+[m[32m  };[m
[32m+[m
[32m+[m[32m  const handleSubmit = (e) => {[m
[32m+[m[32m    e.preventDefault();[m
[32m+[m[32m    console.log('Form submitted:', formData);[m
[32m+[m[32m    // Here you would typically send the data to your backend[m
[32m+[m[32m  };[m
[32m+[m
[32m+[m[32m  // Handle authority selection[m
[32m+[m[32m  const handleSelectAuthority = (authority) => {[m
[32m+[m[32m    if (!selectedAuthorities.some(auth => auth.id === authority.id)) {[m
[32m+[m[32m      setSelectedAuthorities([...selectedAuthorities, authority]);[m
[32m+[m[32m    }[m
[32m+[m[32m    setSearchTerm('');[m
[32m+[m[32m    setShowDropdown(false);[m
[32m+[m[32m  };[m
[32m+[m
[32m+[m[32m  // Handle authority removal[m
[32m+[m[32m  const handleRemoveAuthority = (authorityId) => {[m
[32m+[m[32m    setSelectedAuthorities(selectedAuthorities.filter(auth => auth.id !== authorityId));[m
[32m+[m[32m  };[m
[32m+[m
[32m+[m[32m  // Handle adding new authority[m
[32m+[m[32m  const handleAddAuthority = async () => {[m
[32m+[m[32m    if (!newAuthority.name || !newAuthority.email) {[m
[32m+[m[32m      alert("Both name and email are required for a new authority!");[m
[32m+[m[32m      return;[m
[32m+[m[32m    }[m
[32m+[m
[32m+[m[32m    try {[m
[32m+[m[32m      // Replace with your actual API endpoint[m
[32m+[m[32m      const response = await axios.post("http://127.0.0.1:8000/api/user/createauthorities/", newAuthority);[m
[32m+[m[32m      const createdAuthority = response.data;[m
[32m+[m[41m      [m
[32m+[m[32m      setAvailableAuthorities([...availableAuthorities, createdAuthority]);[m
[32m+[m[32m      setSelectedAuthorities([...selectedAuthorities, createdAuthority]);[m
[32m+[m[32m      setNewAuthority({ name: "", email: "" });[m
[32m+[m[32m      setShowAuthorityForm(false);[m
[32m+[m[41m      [m
[32m+[m[32m    } catch (err) {[m
[32m+[m[32m      console.error("Error adding authority:", err);[m
[32m+[m[32m      alert("Failed to add authority.");[m
[32m+[m[32m    }[m
[32m+[m[32m  };[m
[32m+[m
[32m+[m[32m  // Close dropdown when clicking outside[m
[32m+[m[32m  useEffect(() => {[m
[32m+[m[32m    const handleClickOutside = (event) => {[m
[32m+[m[32m      if (!event.target.closest('.authority-selector')) {[m
[32m+[m[32m        setShowDropdown(false);[m
[32m+[m[32m      }[m
[32m+[m[32m    };[m
[32m+[m[41m    [m
[32m+[m[32m    document.addEventListener('mousedown', handleClickOutside);[m
[32m+[m[32m    return () => document.removeEventListener('mousedown', handleClickOutside);[m
[32m+[m[32m  }, []);[m
[32m+[m
[32m+[m[32m  return ([m
[32m+[m[32m    <div className="create-user-container">[m
[32m+[m[32m      <div className="create-user-header">[m
[32m+[m[32m        <h2>Create New User</h2>[m
[32m+[m[32m        <div className="user-type-indicator">[m
[32m+[m[32m          <span>User</span>[m
[32m+[m[32m          <div className="user-icon">[m
[32m+[m[32m            <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round">[m
[32m+[m[32m              <path d="M20 21v-2a4 4 0 0 0-4-4H8a4 4 0 0 0-4 4v2"></path>[m
[32m+[m[32m              <circle cx="12" cy="7" r="4"></circle>[m
[32m+[m[32m            </svg>[m
[32m+[m[32m          </div>[m
[32m+[m[32m        </div>[m
[32m+[m[32m      </div>[m
[32m+[m
[32m+[m[32m      <form onSubmit={handleSubmit} className="create-user-form">[m
[32m+[m[32m        <div className="form-row">[m
[32m+[m[32m          <div className="form-group">[m
[32m+[m[32m            <label htmlFor="userId">User ID :</label>[m
[32m+[m[32m            <input[m
[32m+[m[32m              type="text"[m
[32m+[m[32m              id="userId"[m
[32m+[m[32m              name="userId"[m
[32m+[m[32m              value={formData.userId}[m
[32m+[m[32m              onChange={handleChange}[m
[32m+[m[32m              required[m
[32m+[m[32m            />[m
[32m+[m[32m          </div>[m
[32m+[m[41m          [m
[32m+[m[32m          <div className="form-group remarks">[m
[32m+[m[32m            <label htmlFor="remarks">Remarks :</label>[m
[32m+[m[32m            <input[m
[32m+[m[32m              type="text"[m
[32m+[m[32m              id="remarks"[m
[32m+[m[32m              name="remarks"[m
[32m+[m[32m              value={formData.remarks}[m
[32m+[m[32m              onChange={handleChange}[m
[32m+[m[32m            />[m
[32m+[m[32m          </div>[m
[32m+[m[32m        </div>[m
[32m+[m
[32m+[m[32m        <div className="form-group">[m
[32m+[m[32m          <label htmlFor="password">Password :</label>[m
[32m+[m[32m          <input[m
[32m+[m[32m            type="password"[m
[32m+[m[32m            id="password"[m
[32m+[m[32m            name="password"[m
[32m+[m[32m            value={formData.password}[m
[32m+[m[32m            onChange={handleChange}[m
[32m+[m[32m            required[m
[32m+[m[32m          />[m
[32m+[m[32m        </div>[m
[32m+[m
[32m+[m[32m        <div className="form-group">[m
[32m+[m[32m          <label htmlFor="email">E-mail :</label>[m
[32m+[m[32m          <input[m
[32m+[m[32m            type="email"[m
[32m+[m[32m            id="email"[m
[32m+[m[32m            name="email"[m
[32m+[m[32m            value={formData.email}[m
[32m+[m[32m            onChange={handleChange}[m
[32m+[m[32m            required[m
[32m+[m[32m          />[m
[32m+[m[32m        </div>[m
[32m+[m
[32m+[m[32m        <div className="form-row categories-row">[m
[32m+[m[32m          <div className="form-group category-group">[m
[32m+[m[32m            <label className="required-label">Category *</label>[m
[32m+[m[32m            <div className="radio-options">[m
[32m+[m[32m              <div className="radio-option">[m
[32m+[m[32m                <input[m
[32m+[m[32m                  type="radio"[m
[32m+[m[32m                  id="academic"[m
[32m+[m[32m                  name="category"[m
[32m+[m[32m                  value="Academic"[m
[32m+[m[32m                  checked={formData.category === "Academic"}[m
[32m+[m[32m                  onChange={handleChange}[m
[32m+[m[32m                  required[m
[32m+[m[32m                />[m
[32m+[m[32m                <label htmlFor="academic">Academic</label>[m
[32m+[m[32m              </div>[m
[32m+[m[41m              [m
[32m+[m[32m              <div className="radio-option">[m
[32m+[m[32m                <input[m
[32m+[m[32m                  type="radio"[m
[32m+[m[32m                  id="nonAcademic"[m
[32m+[m[32m                  name="category"[m
[32m+[m[32m                  value="Non-Academic"[m
[32m+[m[32m                  checked={formData.category === "Non-Academic"}[m
[32m+[m[32m                  onChange={handleChange}[m
[32m+[m[32m                />[m
[32m+[m[32m                <label htmlFor="nonAcademic">Non-Academic</label>[m
[32m+[m[32m              </div>[m
[32m+[m[32m            </div>[m
[32m+[m[32m          </div>[m
[32m+[m
[32m+[m[32m          <div className="form-group authority-group">[m
[32m+[m[32m            <div className="authority-header">[m
[32m+[m[32m              <label className="required-label">Verifying Authority *</label>[m
[32m+[m[32m              <button[m[41m [m
[32m+[m[32m                type="button"[m[41m [m
[32m+[m[32m                className="add-button"[m
[32m+[m[32m                onClick={() => setShowAuthorityForm(!showAuthorityForm)}[m
[32m+[m[32m              >[m
[32m+[m[32m                {showAuthorityForm ? 'Cancel' : 'Add'}[m
[32m+[m[32m                <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round">[m
[32m+[m[32m                  {showAuthorityForm ? ([m
[32m+[m[32m                    <g>[m
[32m+[m[32m                      <circle cx="12" cy="12" r="10"></circle>[m
[32m+[m[32m                      <line x1="8" y1="12" x2="16" y2="12"></line>[m
[32m+[m[32m                    </g>[m
[32m+[m[32m                  ) : ([m
[32m+[m[32m                    <g>[m
[32m+[m[32m                      <circle cx="12" cy="12" r="10"></circle>[m
[32m+[m[32m                      <line x1="12" y1="8" x2="12" y2="16"></line>[m
[32m+[m[32m                      <line x1="8" y1="12" x2="16" y2="12"></line>[m
[32m+[m[32m                    </g>[m
[32m+[m[32m                  )}[m
[32m+[m[32m                </svg>[m
[32m+[m[32m              </button>[m
[32m+[m[32m            </div>[m
[32m+[m[32m            <div className="radio-options">[m
[32m+[m[32m              <div className="radio-option">[m
[32m+[m[32m                <input[m
[32m+[m[32m                  type="radio"[m
[32m+[m[32m                  id="dosa"[m
[32m+[m[32m                  name="verifyingAuthority"[m
[32m+[m[32m                  value="DOSA"[m
[32m+[m[32m                  checked={formData.verifyingAuthority === "DOSA"}[m
[32m+[m[32m                  onChange={handleChange}[m
[32m+[m[32m                  required[m
[32m+[m[32m                />[m
[32m+[m[32m                <label htmlFor="dosa">DOSA</label>[m
[32m+[m[32m              </div>[m
[32m+[m[41m              [m
[32m+[m[32m              <div className="radio-option">[m
[32m+[m[32m                <input[m
[32m+[m[32m                  type="radio"[m
[32m+[m[32m                  id="doaa"[m
[32m+[m[32m                  name="verifyingAuthority"[m
[32m+[m[32m                  value="DOAA"[m
[32m+[m[32m                  checked={formData.verifyingAuthority === "DOAA"}[m
[32m+[m[32m                  onChange={handleChange}[m
[32m+[m[32m                />[m
[32m+[m[32m                <label htmlFor="doaa">DOAA</label>[m
[32m+[m[32m              </div>[m
[32m+[m[41m              [m
[32m+[m[32m              <div className="radio-option">[m
[32m+[m[32m                <input[m
[32m+[m[32m                  type="radio"[m
[32m+[m[32m                  id="general"[m
[32m+[m[32m                  name="verifyingAuthority"[m
[32m+[m[32m                  value="General Sec(SnT)"[m
[32m+[m[32m                  checked={formData.verifyingAuthority === "General Sec(SnT)"}[m
[32m+[m[32m                  onChange={handleChange}[m
[32m+[m[32m                />[m
[32m+[m[32m                <label htmlFor="general">General Sec(SnT)</label>[m
[32m+[m[32m              </div>[m
[32m+[m[41m              [m
[32m+[m[32m              <div className="radio-option">[m
[32m+[m[32m                <input[m
[32m+[m[32m                  type="radio"[m
[32m+[m[32m                  id="none"[m
[32m+[m[32m                  name="verifyingAuthority"[m
[32m+[m[32m                  value="None"[m
[32m+[m[32m                  checked={formData.verifyingAuthority === "None"}[m
[32m+[m[32m                  onChange={handleChange}[m
[32m+[m[32m                />[m
[32m+[m[32m                <label htmlFor="none">None</label>[m
[32m+[m[32m              </div>[m
[32m+[m[32m            </div>[m
[32m+[m[32m          </div>[m
[32m+[m[32m        </div>[m
[32m+[m
[32m+[m[32m        {/* New Authority Form */}[m
[32m+[m[32m        {showAuthorityForm && ([m
[32m+[m[32m          <div className="new-authority-form">[m
[32m+[m[32m            <h4>Add New Authority</h4>[m
[32m+[m[32m            <div className="form-row">[m
[32m+[m[32m              <div className="form-group">[m
[32m+[m[32m                <label htmlFor="authorityName">Authority Name:</label>[m
[32m+[m[32m                <input[m
[32m+[m[32m                  type="text"[m
[32m+[m[32m                  id="authorityName"[m
[32m+[m[32m                  value={newAuthority.name}[m
[32m+[m[32m                  onChange={(e) => setNewAuthority({...newAuthority, name: e.target.value})}[m
[32m+[m[32m                />[m
[32m+[m[32m              </div>[m
[32m+[m[32m              <div className="form-group">[m
[32m+[m[32m                <label htmlFor="authorityEmail">Authority Email:</label>[m
[32m+[m[32m                <input[m
[32m+[m[32m                  type="email"[m
[32m+[m[32m                  id="authorityEmail"[m
[32m+[m[32m                  value={newAuthority.email}[m
[32m+[m[32m                  onChange={(e) => setNewAuthority({...newAuthority, email: e.target.value})}[m
[32m+[m[32m                />[m
[32m+[m[32m              </div>[m
[32m+[m[32m            </div>[m
[32m+[m[32m            <button[m[41m [m
[32m+[m[32m              type="button"[m[41m [m
[32m+[m[32m              className="add-authority-button"[m
[32m+[m[32m              onClick={handleAddAuthority}[m
[32m+[m[32m            >[m
[32m+[m[32m              Add Authority[m
[32m+[m[32m            </button>[m
[32m+[m[32m          </div>[m
[32m+[m[32m        )}[m
[32m+[m
[32m+[m[32m        {/* Multiple Authorities Selector */}[m
[32m+[m[32m        <div className="form-group">[m
[32m+[m[32m          <label>Additional Authorities:</label>[m
[32m+[m[32m          <div className="authority-selector">[m
[32m+[m[32m            {/* Selected Authorities Display */}[m
[32m+[m[32m            <div className="selected-authorities">[m
[32m+[m[32m              {selectedAuthorities.map(auth => ([m
[32m+[m[32m                <div key={auth.id} className="selected-authority">[m
[32m+[m[32m                  <span>{auth.name}</span>[m
[32m+[m[32m                  <button[m[41m [m
[32m+[m[32m                    type="button"[m
[32m+[m[32m                    onClick={() => handleRemoveAuthority(auth.id)}[m
[32m+[m[32m                    className="remove-authority"[m
[32m+[m[32m                  >[m
[32m+[m[32m                    ×[m
[32m+[m[32m                  </button>[m
[32m+[m[32m                </div>[m
[32m+[m[32m              ))}[m
[32m+[m[32m            </div>[m
[32m+[m[41m            [m
[32m+[m[32m            {/* Authority Search Input */}[m
[32m+[m[32m            <div className="authority-search">[m
[32m+[m[32m              <input[m
[32m+[m[32m                type="text"[m
[32m+[m[32m                placeholder="Search for authorities..."[m
[32m+[m[32m                value={searchTerm}[m
[32m+[m[32m                onChange={(e) => setSearchTerm(e.target.value)}[m
[32m+[m[32m                onFocus={() => setShowDropdown(true)}[m
[32m+[m[32m                onClick={() => setShowDropdown(true)}[m
[32m+[m[32m              />[m
[32m+[m[41m              [m
[32m+[m[32m              {/* Dropdown for authority selection */}[m
[32m+[m[32m              {showDropdown && ([m
[32m+[m[32m                <div className="authority-dropdown">[m
[32m+[m[32m                  {filteredAuthorities.length > 0 ? ([m
[32m+[m[32m                    filteredAuthorities.map(auth => ([m
[32m+[m[32m                      <div[m[41m [m
[32m+[m[32m                        key={auth.id}[m[41m [m
[32m+[m[32m                        className="authority-option"[m
[32m+[m[32m                        onClick={() => handleSelectAuthority(auth)}[m
[32m+[m[32m                      >[m
[32m+[m[32m                        {auth.name}[m
[32m+[m[32m                      </div>[m
[32m+[m[32m                    ))[m
[32m+[m[32m                  ) : ([m
[32m+[m[32m                    <div className="no-results">No authorities found</div>[m
[32m+[m[32m                  )}[m
[32m+[m[32m                </div>[m
[32m+[m[32m              )}[m
[32m+[m[32m            </div>[m
[32m+[m[32m          </div>[m
[32m+[m[32m        </div>[m
[32m+[m
[32m+[m[32m        <div className="form-actions">[m
[32m+[m[32m          <button type="submit" className="confirm-button">Confirm</button>[m
[32m+[m[32m        </div>[m
[32m+[m[32m      </form>[m
[32m+[m[32m    </div>[m
[32m+[m[32m  );[m
[32m+[m[32m};[m
[32m+[m
[32m+[m[32mexport default CreateUser;[m
[32m+[m
[32m+[m
[32m+[m
[32m+[m
[1mdiff --git a/frontend_LHB3/src/pages/Feedback.jsx b/frontend_LHB3/src/pages/Feedback.jsx[m
[1mnew file mode 100644[m
[1mindex 0000000..f850151[m
[1m--- /dev/null[m
[1m+++ b/frontend_LHB3/src/pages/Feedback.jsx[m
[36m@@ -0,0 +1,50 @@[m
[32m+[m[32mimport React from 'react'[m
[32m+[m
[32m+[m[32m// TODO: Backend Integration Comments:[m
[32m+[m
[32m+[m[32m// 1. Feedback Submission:[m
[32m+[m[32m// - Replace placeholder with actual feedback form[m
[32m+[m[32m// - Create src/api/feedback.js for feedback endpoints[m
[32m+[m[32m// - Implement POST /api/feedback with proper validation[m
[32m+[m[32m// - Include booking reference if feedback is related to specific booking[m
[32m+[m
[32m+[m[32m// 2. Form Implementation:[m
[32m+[m[32m// - Add form fields:[m
[32m+[m[32m//   a) Feedback category/type dropdown[m
[32m+[m[32m//   b) Rating system (stars, numeric)[m
[32m+[m[32m//   c) Detailed comments text area[m
[32m+[m[32m//   d) Optional: attachments for screenshots/evidence[m
[32m+[m
[32m+[m[32m// 3. Validation:[m
[32m+[m[32m// - Require minimum length for meaningful feedback[m
[32m+[m[32m// - Validate all fields before submission[m
[32m+[m[32m// - Prevent spam submissions (rate limiting)[m
[32m+[m
[32m+[m[32m// 4. Success Handling:[m
[32m+[m[32m// - Show success message after submission[m
[32m+[m[32m// - Clear form or provide option to submit another feedback[m
[32m+[m[32m// - Optionally redirect to dashboard[m
[32m+[m
[32m+[m[32m// 5. Previous Feedback:[m
[32m+[m[32m// - Fetch and display user's previous feedback submissions[m
[32m+[m[32m// - Allow viewing responses to past feedback[m
[32m+[m[32m// - Implement GET /api/feedback/history[m
[32m+[m
[32m+[m[32m// 6. Admin Response:[m
[32m+[m[32m// - For admin users, show interface to respond to feedback[m
[32m+[m[32m// - Implement POST /api/admin/feedback/{id}/respond[m
[32m+[m[32m// - Add status indicators for responded/unresponded feedback[m
[32m+[m
[32m+[m[32mconst Feedback = () => {[m
[32m+[m[32m  return ([m
[32m+[m[32m    <div style={{ fontFamily: 'Arial, sans-serif', textAlign: 'center', padding: '20px', backgroundColor: '#f0f8ff', borderRadius: '10px', boxShadow: '0 4px 8px rgba(0, 0, 0, 0.2)' }}>[m
[32m+[m[32m        <h1 style={{ color: '#4CAF50' }}>I hope you enjoy our software, if not ,[m
[32m+[m[32m            kindly humbly mera mu me lelein</h1>[m
[32m+[m[32m        <p style={{ fontSize: '18px', color: '#555' }}>[m
[32m+[m[32m            Maa chuda le bhai merko pata h website acchi h mera la*da le feedback[m[41m [m
[32m+[m[32m        </p>[m
[32m+[m[32m    </div>[m
[32m+[m[32m  )[m
[32m+[m[32m}[m
[32m+[m
[32m+[m[32mexport default Feedback[m
\ No newline at end of file[m
[1mdiff --git a/frontend_LHB3/src/pages/Help.jsx b/frontend_LHB3/src/pages/Help.jsx[m
[1mnew file mode 100644[m
[1mindex 0000000..f602443[m
[1m--- /dev/null[m
[1m+++ b/frontend_LHB3/src/pages/Help.jsx[m
[36m@@ -0,0 +1,44 @@[m
[32m+[m[32mimport React from 'react'[m
[32m+[m
[32m+[m[32m// TODO: Backend Integration Comments:[m
[32m+[m
[32m+[m[32m// 1. Help Content Fetching:[m
[32m+[m[32m// - Replace placeholder with dynamic help content[m
[32m+[m[32m// - Create src/api/content.js for CMS-related endpoints[m
[32m+[m[32m// - Fetch help articles via GET /api/content/help[m
[32m+[m[32m// - Support markdown or HTML content rendering[m
[32m+[m
[32m+[m[32m// 2. Search Functionality:[m
[32m+[m[32m// - Implement help content search[m
[32m+[m[32m// - Call GET /api/content/help/search?query=...[m
[32m+[m[32m// - Add typeahead/autocomplete for better UX[m
[32m+[m
[32m+[m[32m// 3. Categories and Navigation:[m
[32m+[m[32m// - Fetch help categories from backend[m
[32m+[m[32m// - Organize help content in expandable sections[m
[32m+[m[32m// - Add breadcrumb navigation for deep content[m
[32m+[m
[32m+[m[32m// 4. User Context:[m
[32m+[m[32m// - Show personalized help based on user role[m
[32m+[m[32m// - Pre-filter content relevant to current user actions[m
[32m+[m[32m// - Track commonly accessed help topics[m
[32m+[m
[32m+[m[32m// 5. Interactive Elements:[m
[32m+[m[32m// - Add FAQ section with expandable answers[m
[32m+[m[32m// - Implement guided tutorials/walkthroughs[m
[32m+[m[32m// - Include video embeds if applicable[m
[32m+[m
[32m+[m[32m// 6. Feedback on Help Content:[m
[32m+[m[32m// - Add "Was this helpful?" buttons[m
[32m+[m[32m// - Send feedback via POST /api/content/help/{id}/feedback[m
[32m+[m[32m// - Track most useful/least useful articles[m
[32m+[m
[32m+[m[32mconst Help = () => {[m
[32m+[m[32m  return ([m
[32m+[m[32m    <div style={{ display: 'flex', justifyContent: 'center', alignItems: 'center', height: '100vh', fontSize: '3rem' }}>[m
[32m+[m[32m        Help to mujhe bhi chahiye bhai pr duniya madrchod h[m
[32m+[m[32m    </div>[m
[32m+[m[32m  )[m
[32m+[m[32m}[m
[32m+[m
[32m+[m[32mexport default Help[m
\ No newline at end of file[m
[1mdiff --git a/frontend_LHB3/src/pages/History.css b/frontend_LHB3/src/pages/History.css[m
[1mnew file mode 100644[m
[1mindex 0000000..97e0239[m
[1m--- /dev/null[m
[1m+++ b/frontend_LHB3/src/pages/History.css[m
[36m@@ -0,0 +1,114 @@[m
[32m+[m[32m.history-container {[m
[32m+[m[32m    width: 100%;[m
[32m+[m[32m    padding: 20px;[m
[32m+[m[32m    background-color: #f5f8ff;[m
[32m+[m[32m    border-radius: 8px;[m
[32m+[m[32m  }[m
[32m+[m[41m  [m
[32m+[m[32m  .history-title {[m
[32m+[m[32m    display: flex;[m
[32m+[m[32m    justify-content: center;[m
[32m+[m[32m    margin-bottom: 20px;[m
[32m+[m[32m  }[m
[32m+[m[41m  [m
[32m+[m[32m  .month-navigation {[m
[32m+[m[32m    display: flex;[m
[32m+[m[32m    align-items: center;[m
[32m+[m[32m    gap: 10px;[m
[32m+[m[32m    color: #333;[m
[32m+[m[32m    font-weight: 500;[m
[32m+[m[32m  }[m
[32m+[m[41m  [m
[32m+[m[32m  .nav-button {[m
[32m+[m[32m    background: none;[m
[32m+[m[32m    border: none;[m
[32m+[m[32m    cursor: pointer;[m
[32m+[m[32m    font-size: 18px;[m
[32m+[m[32m    color: #555;[m
[32m+[m[32m  }[m
[32m+[m[41m  [m
[32m+[m[32m  .bookings-section {[m
[32m+[m[32m    background-color: #fff;[m
[32m+[m[32m    border-radius: 8px;[m
[32m+[m[32m    padding: 15px;[m
[32m+[m[32m    box-shadow: 0 2px 5px rgba(0, 0, 0, 0.05);[m
[32m+[m[32m  }[m
[32m+[m[41m  [m
[32m+[m[32m  .bookings-section h3 {[m
[32m+[m[32m    margin-top: 0;[m
[32m+[m[32m    margin-bottom: 15px;[m
[32m+[m[32m    font-size: 18px;[m
[32m+[m[32m    color: #333;[m
[32m+[m[32m  }[m
[32m+[m[41m  [m
[32m+[m[32m  .bookings-table {[m
[32m+[m[32m    width: 100%;[m
[32m+[m[32m    border-collapse: collapse;[m
[32m+[m[32m  }[m
[32m+[m[41m  [m
[32m+[m[32m  .table-header {[m
[32m+[m[32m    display: grid;[m
[32m+[m[32m    grid-template-columns: 2fr 1fr 1.5fr 1fr 1fr 0.5fr;[m
[32m+[m[32m    background-color: #6777ef;[m
[32m+[m[32m    color: white;[m
[32m+[m[32m    font-weight: 500;[m
[32m+[m[32m    border-radius: 4px 4px 0 0;[m
[32m+[m[32m  }[m
[32m+[m[41m  [m
[32m+[m[32m  .header-cell {[m
[32m+[m[32m    padding: 12px 15px;[m
[32m+[m[32m    text-align: left;[m
[32m+[m[32m  }[m
[32m+[m[41m  [m
[32m+[m[32m  .table-row {[m
[32m+[m[32m    display: grid;[m
[32m+[m[32m    grid-template-columns: 2fr 1fr 1.5fr 1fr 1fr 0.5fr;[m
[32m+[m[32m    border-bottom: 1px solid #eee;[m
[32m+[m[32m  }[m
[32m+[m[41m  [m
[32m+[m[32m  .cell {[m
[32m+[m[32m    padding: 12px 15px;[m
[32m+[m[32m    text-align: left;[m
[32m+[m[32m  }[m
[32m+[m[41m  [m
[32m+[m[32m  .download-button {[m
[32m+[m[32m    background: none;[m
[32m+[m[32m    border: none;[m
[32m+[m[32m    cursor: pointer;[m
[32m+[m[32m    color: #6777ef;[m
[32m+[m[32m  }[m
[32m+[m[41m  [m
[32m+[m[32m  .download-button:hover {[m
[32m+[m[32m    color: #4a5ac9;[m
[32m+[m[32m  }[m
[32m+[m[41m  [m
[32m+[m[32m  .total-section {[m
[32m+[m[32m    display: flex;[m
[32m+[m[32m    justify-content: flex-end;[m
[32m+[m[32m    margin-top: 15px;[m
[32m+[m[32m    padding: 8px 15px;[m
[32m+[m[32m  }[m
[32m+[m[41m  [m
[32m+[m[32m  .total-section span {[m
[32m+[m[32m    background-color: #b7c4ff;[m
[32m+[m[32m    padding: 6px 15px;[m
[32m+[m[32m    border-radius: 15px;[m
[32m+[m[32m    font-weight: 500;[m
[32m+[m[32m  }[m
[32m+[m[41m  [m
[32m+[m[32m  /* Responsive adjustments */[m
[32m+[m[32m  @media (max-width: 768px) {[m
[32m+[m[32m    .table-header, .table-row {[m
[32m+[m[32m      grid-template-columns: 2fr 1fr 1fr;[m
[32m+[m[32m    }[m
[32m+[m[41m    [m
[32m+[m[32m    .header-cell.time, .cell.time,[m
[32m+[m[32m    .header-cell.hall, .cell.hall,[m
[32m+[m[32m    .header-cell.download, .cell.download {[m
[32m+[m[32m      display: none;[m
[32m+[m[32m    }[m
[32m+[m[41m    [m
[32m+[m[32m    .total-section {[m
[32m+[m[32m      justify-content: center;[m
[32m+[m[32m    }[m
[32m+[m[32m  }[m
\ No newline at end of file[m
[1mdiff --git a/frontend_LHB3/src/pages/Home.jsx b/frontend_LHB3/src/pages/Home.jsx[m
[1mnew file mode 100644[m
[1mindex 0000000..f4a798e[m
[1m--- /dev/null[m
[1m+++ b/frontend_LHB3/src/pages/Home.jsx[m
[36m@@ -0,0 +1,11 @@[m
[32m+[m[32mimport React from 'react'[m
[32m+[m
[32m+[m[32mconst Home = () => {[m
[32m+[m[32m  return ([m
[32m+[m[32m    <div>[m
[32m+[m[32m        HOME PAGE testing lesgo[m
[32m+[m[32m    </div>[m
[32m+[m[32m  )[m
[32m+[m[32m}[m
[32m+[m
[32m+[m[32mexport default Home[m
\ No newline at end of file[m
[1mdiff --git a/frontend_LHB3/src/pages/LiveSchedule.css b/frontend_LHB3/src/pages/LiveSchedule.css[m
[1mnew file mode 100644[m
[1mindex 0000000..0fb4c34[m
[1m--- /dev/null[m
[1m+++ b/frontend_LHB3/src/pages/LiveSchedule.css[m
[36m@@ -0,0 +1,137 @@[m
[32m+[m[32m/* LiveSchedule.css */[m
[32m+[m[32m.live-schedule-container {[m
[32m+[m[32m    width: 100%;[m
[32m+[m[32m    max-width: 100%;[m
[32m+[m[32m    padding: 20px;[m
[32m+[m[32m    font-family: Arial, sans-serif;[m
[32m+[m[32m  }[m
[32m+[m[41m  [m
[32m+[m[32m  .date-navigator {[m
[32m+[m[32m    display: flex;[m
[32m+[m[32m    align-items: center;[m
[32m+[m[32m    justify-content: center;[m
[32m+[m[32m    margin-bottom: 20px;[m
[32m+[m[32m  }[m
[32m+[m[41m  [m
[32m+[m[32m  .nav-button {[m
[32m+[m[32m    background-color: #f0f0f0;[m
[32m+[m[32m    border: none;[m
[32m+[m[32m    border-radius: 4px;[m
[32m+[m[32m    padding: 5px 10px;[m
[32m+[m[32m    cursor: pointer;[m
[32m+[m[32m    margin: 0 10px;[m
[32m+[m[32m  }[m
[32m+[m[41m  [m
[32m+[m[32m  .current-date {[m
[32m+[m[32m    font-size: 14px;[m
[32m+[m[32m    font-weight: bold;[m
[32m+[m[32m  }[m
[32m+[m[41m  [m
[32m+[m[32m  .timetable-container {[m
[32m+[m[32m    width: 100%;[m
[32m+[m[32m    overflow-x: auto;[m
[32m+[m[32m  }[m
[32m+[m[41m  [m
[32m+[m[32m  .timetable {[m
[32m+[m[32m    display: flex;[m
[32m+[m[32m    min-width: 800px;[m
[32m+[m[32m  }[m
[32m+[m[41m  [m
[32m+[m[32m  .time-column {[m
[32m+[m[32m    width: 80px;[m
[32m+[m[32m    flex-shrink: 0;[m
[32m+[m[32m  }[m
[32m+[m[41m  [m
[32m+[m[32m  .time-slot {[m
[32m+[m[32m    height: 60px;[m
[32m+[m[32m    display: flex;[m
[32m+[m[32m    align-items: center;[m
[32m+[m[32m    justify-content: center;[m
[32m+[m[32m    font-size: 12px;[m
[32m+[m[32m    border-bottom: 1px solid #e0e0e0;[m
[32m+[m[32m  }[m
[32m+[m[41m  [m
[32m+[m[32m  .halls-grid {[m
[32m+[m[32m    flex-grow: 1;[m
[32m+[m[32m    display: flex;[m
[32m+[m[32m    flex-direction: column;[m
[32m+[m[32m  }[m
[32m+[m[41m  [m
[32m+[m[32m  .hall-headers {[m
[32m+[m[32m    display: flex;[m
[32m+[m[32m    background-color: #f8f8f8;[m
[32m+[m[32m  }[m
[32m+[m[41m  [m
[32m+[m[32m  .hall-header {[m
[32m+[m[32m    flex: 1;[m
[32m+[m[32m    text-align: center;[m
[32m+[m[32m    padding: 10px;[m
[32m+[m[32m    font-weight: bold;[m
[32m+[m[32m    font-size: 14px;[m
[32m+[m[32m    border-left: 1px solid #e0e0e0;[m
[32m+[m[32m    border-bottom: 1px solid #e0e0e0;[m
[32m+[m[32m  }[m
[32m+[m[41m  [m
[32m+[m[32m  .bookings-grid {[m
[32m+[m[32m    display: flex;[m
[32m+[m[32m    flex-direction: column;[m
[32m+[m[32m  }[m
[32m+[m[41m  [m
[32m+[m[32m  .time-row {[m
[32m+[m[32m    display: flex;[m
[32m+[m[32m    height: 60px;[m
[32m+[m[32m  }[m
[32m+[m[41m  [m
[32m+[m[32m  .booking-cell {[m
[32m+[m[32m    flex: 1;[m
[32m+[m[32m    border-left: 1px solid #e0e0e0;[m
[32m+[m[32m    border-bottom: 1px solid #e0e0e0;[m
[32m+[m[32m    padding: 5px;[m
[32m+[m[32m    position: relative;[m
[32m+[m[32m  }[m
[32m+[m[41m  [m
[32m+[m[32m  .booking-item {[m
[32m+[m[32m    position: relative;[m
[32m+[m[32m    background-color: #f0f4f8;[m
[32m+[m[32m    padding: 8px;[m
[32m+[m[32m    border-radius: 4px;[m
[32m+[m[32m    display: flex;[m
[32m+[m[32m    flex-direction: column;[m
[32m+[m[32m    gap: 4px;[m
[32m+[m[32m    height: 100%;[m
[32m+[m[32m    border: 1px solid #2c3e50; /* Makes the border bolder and darker */[m
[32m+[m[32m    box-shadow: 0 2px 4px rgba(13, 9, 9, 0.1);[m
[32m+[m[32m  }[m
[32m+[m[41m  [m
[32m+[m[32m  .booking-indicator {[m
[32m+[m[32m    position: absolute;[m
[32m+[m[32m    left: 0;[m
[32m+[m[32m    top: 0;[m
[32m+[m[32m    bottom: 0;[m
[32m+[m[32m    width: 6px;[m
[32m+[m[32m    background-color: #3498db;[m
[32m+[m[32m    border-top-left-radius: 4px;[m
[32m+[m[32m    border-bottom-left-radius: 4px;[m
[32m+[m[32m  }[m
[32m+[m[41m  [m
[32m+[m[32m  .course-code {[m
[32m+[m[32m    font-weight: 600;[m
[32m+[m[32m    font-size: 0.9rem;[m
[32m+[m[32m    color: #173b5f;[m
[32m+[m[32m  }[m
[32m+[m[41m  [m
[32m+[m[41m  [m
[32m+[m[32m  .dropdown-button {[m
[32m+[m[32m    background: none;[m
[32m+[m[32m    border: none;[m
[32m+[m[32m    color: #999;[m
[32m+[m[32m    cursor: pointer;[m
[32m+[m[32m    font-size: 10px;[m
[32m+[m[32m  }[m
[32m+[m[41m  [m
[32m+[m[32m  /* Responsive adjustments */[m
[32m+[m[32m  @media (max-width: 768px) {[m
[32m+[m[32m    .timetable {[m
[32m+[m[32m      min-width: 600px;[m
[32m+[m[32m    }[m
[32m+[m[32m  }[m
\ No newline at end of file[m
[1mdiff --git a/frontend_LHB3/src/pages/LiveSchedule.jsx b/frontend_LHB3/src/pages/LiveSchedule.jsx[m
[1mnew file mode 100644[m
[1mindex 0000000..8166eb5[m
[1m--- /dev/null[m
[1m+++ b/frontend_LHB3/src/pages/LiveSchedule.jsx[m
[36m@@ -0,0 +1,143 @@[m
[32m+[m[32mimport React, { useState } from 'react';[m
[32m+[m[32mimport './LiveSchedule.css';[m
[32m+[m
[32m+[m[32m// TODO: Backend Integration Comments:[m
[32m+[m
[32m+[m[32m// 1. Data Fetching:[m
[32m+[m[32m// - Replace mock data with API calls[m
[32m+[m[32m// - Create src/api/schedule.js for schedule-related endpoints[m
[32m+[m[32m// - Call GET /api/schedule?date=YYYY-MM-DD to get bookings for a specific date[m
[32m+[m[32m// - Add useEffect hook to fetch data when component mounts or date changes[m
[32m+[m
[32m+[m[32m// 2. Loading States:[m
[32m+[m[32m// - Add loading indicators while fetching data[m
[32m+[m[32m// - Implement error handling for failed API calls[m
[32m+[m[32m// - Add empty state UI for days with no bookings[m
[32m+[m
[32m+[m[32m// 3. Booking Details:[m
[32m+[m[32m// - Add modal/popup for viewing booking details[m
[32m+[m[32m// - Fetch detailed information via GET /api/bookings/{bookingId}[m
[32m+[m[32m// - Consider caching frequently accessed data[m
[32m+[m
[32m+[m[32m// 4. Real-time Updates:[m
[32m+[m[32m// - Implement WebSocket connection for live schedule updates[m
[32m+[m[32m// - Update UI when new bookings are made or existing ones are changed[m
[32m+[m[32m// - Consider a polling fallback if WebSockets aren't available[m
[32m+[m
[32m+[m[32m// 5. Filtering and Search:[m
[32m+[m[32m// - Add backend-driven filters (by hall, time, department)[m
[32m+[m[32m// - Implement search functionality via GET /api/schedule/search?query=...[m
[32m+[m
[32m+[m[32m// 6. Date Navigation:[m
[32m+[m[32m// - Keep selected date in URL for shareable links[m
[32m+[m[32m// - Optimize API calls to avoid unnecessary data fetching[m
[32m+[m
[32m+[m[32mconst LiveSchedule = () => {[m
[32m+[m[32m  const [selectedDate, setSelectedDate] = useState(new Date());[m
[32m+[m
[32m+[m[32m  // Format date to display as "TUESDAY, JANUARY 21, 2025"[m
[32m+[m[32m  const formatDate = (date) => {[m
[32m+[m[32m    return date.toLocaleString('en-US', {[m[41m [m
[32m+[m[32m      weekday: 'long',[m[41m [m
[32m+[m[32m      month: 'long',[m[41m [m
[32m+[m[32m      day: 'numeric',[m[41m [m
[32m+[m[32m      year: 'numeric'[m[41m [m
[32m+[m[32m    }).toUpperCase();[m
[32m+[m[32m  };[m
[32m+[m
[32m+[m[32m  // Navigate to previous day[m
[32m+[m[32m  const previousDay = () => {[m
[32m+[m[32m    const newDate = new Date(selectedDate);[m
[32m+[m[32m    newDate.setDate(selectedDate.getDate() - 1);[m
[32m+[m[32m    setSelectedDate(newDate);[m
[32m+[m[32m  };[m
[32m+[m
[32m+[m[32m  // Navigate to next day[m
[32m+[m[32m  const nextDay = () => {[m
[32m+[m[32m    const newDate = new Date(selectedDate);[m
[32m+[m[32m    newDate.setDate(selectedDate.getDate() + 1);[m
[32m+[m[32m    setSelectedDate(newDate);[m
[32m+[m[32m  };[m
[32m+[m
[32m+[m[32m  // Mock data for lecture halls[m
[32m+[m[32m  const lectureHalls = ['LH1', 'LH2', 'LH3', 'LH5', 'LH6', 'LH7', 'LH8', 'LH9'];[m
[32m+[m[41m  [m
[32m+[m[32m  // Mock data for time slots[m
[32m+[m[32m  const timeSlots = [[m
[32m+[m[32m    '8:00 AM',[m
[32m+[m[32m    '9:00 AM',[m
[32m+[m[32m    '10:00 AM',[m
[32m+[m[32m    '11:00 AM',[m
[32m+[m[32m    '12:00 PM',[m
[32m+[m[32m    '1:00 PM',[m
[32m+[m[32m    '2:00 PM'[m
[32m+[m[32m  ];[m
[32m+[m
[32m+[m[32m  // Mock data for bookings[m
[32m+[m[32m  const bookings = [[m
[32m+[m[32m    { hall: 'LH1', time: '10:00 AM', course: 'CS202', dropdown: true },[m
[32m+[m[32m    { hall: 'LH2', time: '10:00 AM', course: 'CS202', dropdown: true },[m
[32m+[m[32m    { hall: 'LH3', time: '11:00 AM', course: 'MTH112 QUIZ', dropdown: true },[m
[32m+[m[32m    { hall: 'LH5', time: '9:00 AM', course: 'PCLUB SESSION', dropdown: true },[m
[32m+[m[32m    { hall: 'LH7', time: '11:00 AM', course: 'CS771', dropdown: true },[m
[32m+[m[32m    { hall: 'LH1', time: '12:00 PM', course: 'CS253', dropdown: true },[m
[32m+[m[32m  ];[m
[32m+[m
[32m+[m[32m  // Get booking for a specific hall and time[m
[32m+[m[32m  const getBooking = (hall, time) => {[m
[32m+[m[32m    return bookings.find(booking => booking.hall === hall && booking.time === time);[m
[32m+[m[32m  };[m
[32m+[m
[32m+[m[32m  return ([m
[32m+[m[32m    <div className="live-schedule-container">[m
[32m+[m[32m      <div className="date-navigator">[m
[32m+[m[32m        <button onClick={previousDay} className="nav-button">&lt;</button>[m
[32m+[m[32m        <div className="current-date">{formatDate(selectedDate)}</div>[m
[32m+[m[32m        <button onClick={nextDay} className="nav-button">&gt;</button>[m
[32m+[m[32m      </div>[m
[32m+[m[41m      [m
[32m+[m[32m      <div className="timetable-container">[m
[32m+[m[32m        <div className="timetable">[m
[32m+[m[32m          <div className="time-column">[m
[32m+[m[32m            {timeSlots.map((time, index) => ([m
[32m+[m[32m              <div key={index} className="time-slot">{time}</div>[m
[32m+[m[32m            ))}[m
[32m+[m[32m          </div>[m
[32m+[m[41m          [m
[32m+[m[32m          <div className="halls-grid">[m
[32m+[m[32m            <div className="hall-headers">[m
[32m+[m[32m              {lectureHalls.map((hall, index) => ([m
[32m+[m[32m                <div key={index} className="hall-header">{hall}</div>[m
[32m+[m[32m              ))}[m
[32m+[m[32m            </div>[m
[32m+[m[41m            [m
[32m+[m[32m            <div className="bookings-grid">[m
[32m+[m[32m              {timeSlots.map((time, timeIndex) => ([m
[32m+[m[32m                <div key={timeIndex} className="time-row">[m
[32m+[m[32m                  {lectureHalls.map((hall, hallIndex) => {[m
[32m+[m[32m                    const booking = getBooking(hall, time);[m
[32m+[m[32m                    return ([m
[32m+[m[32m                      <div key={hallIndex} className="booking-cell">[m
[32m+[m[32m                        {booking && ([m
[32m+[m[32m                          <div className="booking-item">[m
[32m+[m[32m                            <div className="booking-indicator"></div>[m
[32m+[m[32m                            <div className="course-code">{booking.course}</div>[m
[32m+[m[32m                            {booking.dropdown && ([m
[32m+[m[32m                              <button className="dropdown-button">▼</button>[m
[32m+[m[32m                            )}[m
[32m+[m[32m                          </div>[m
[32m+[m[32m                        )}[m
[32m+[m[32m                      </div>[m
[32m+[m[32m                    );[m
[32m+[m[32m                  })}[m
[32m+[m[32m                </div>[m
[32m+[m[32m              ))}[m
[32m+[m[32m            </div>[m
[32m+[m[32m          </div>[m
[32m+[m[32m        </div>[m
[32m+[m[32m      </div>[m
[32m+[m[32m    </div>[m
[32m+[m[32m  );[m
[32m+[m[32m};[m
[32m+[m
[32m+[m[32mexport default LiveSchedule;[m
\ No newline at end of file[m
[1mdiff --git a/frontend_LHB3/src/pages/Login.css b/frontend_LHB3/src/pages/Login.css[m
[1mnew file mode 100644[m
[1mindex 0000000..7fce9e5[m
[1m--- /dev/null[m
[1m+++ b/frontend_LHB3/src/pages/Login.css[m
[36m@@ -0,0 +1,127 @@[m
[32m+[m[32m.login-page {[m
[32m+[m[32m    display: flex;[m
[32m+[m[32m    min-height: 100vh;[m
[32m+[m[32m    background-color: #f5f5f5;[m
[32m+[m[32m    padding: 20px;[m
[32m+[m[32m  }[m
[32m+[m[41m  [m
[32m+[m[32m  .login-container {[m
[32m+[m[32m    display: flex;[m
[32m+[m[32m    width: 100%;[m
[32m+[m[32m    max-width: 1200px;[m
[32m+[m[32m    margin: auto;[m
[32m+[m[32m    background: white;[m
[32m+[m[32m    border-radius: 20px;[m
[32m+[m[32m    overflow: hidden;[m
[32m+[m[32m    box-shadow: 0 4px 20px rgba(0, 0, 0, 0.1);[m
[32m+[m[32m  }[m
[32m+[m[41m  [m
[32m+[m[32m  .login-image-container {[m
[32m+[m[32m    flex: 1;[m
[32m+[m[32m    background: linear-gradient(rgba(0, 0, 0, 0.5), rgba(0, 0, 0, 0.5)),[m
[32m+[m[32m                url('/campus-image.jpg');[m
[32m+[m[32m    background-size: cover;[m
[32m+[m[32m    background-position: center;[m
[32m+[m[32m  }[m
[32m+[m[41m  [m
[32m+[m[32m  .login-form-container {[m
[32m+[m[32m    flex: 1;[m
[32m+[m[32m    padding: 40px;[m
[32m+[m[32m    display: flex;[m
[32m+[m[32m    flex-direction: column;[m
[32m+[m[32m  }[m
[32m+[m[41m  [m
[32m+[m[32m  .logo-container {[m
[32m+[m[32m    display: flex;[m
[32m+[m[32m    align-items: center;[m
[32m+[m[32m    gap: 12px;[m
[32m+[m[32m    margin-bottom: 40px;[m
[32m+[m[32m  }[m
[32m+[m[41m  [m
[32m+[m[32m  .iit-logo {[m
[32m+[m[32m    height: 50px;[m
[32m+[m[32m    width: auto;[m
[32m+[m[32m  }[m
[32m+[m[41m  [m
[32m+[m[32m  .logo-container span {[m
[32m+[m[32m    font-size: 24px;[m
[32m+[m[32m    font-weight: 600;[m
[32m+[m[32m    color: #333;[m
[32m+[m[32m  }[m
[32m+[m[41m  [m
[32m+[m[32m  .login-form-content h2 {[m
[32m+[m[32m    color: #666;[m
[32m+[m[32m    font-size: 18px;[m
[32m+[m[32m    margin-bottom: 8px;[m
[32m+[m[32m  }[m
[32m+[m[41m  [m
[32m+[m[32m  .login-form-content h1 {[m
[32m+[m[32m    color: #333;[m
[32m+[m[32m    font-size: 28px;[m
[32m+[m[32m    margin-bottom: 32px;[m
[32m+[m[32m  }[m
[32m+[m[41m  [m
[32m+[m[32m  .login-form {[m
[32m+[m[32m    display: flex;[m
[32m+[m[32m    flex-direction: column;[m
[32m+[m[32m    gap: 24px;[m
[32m+[m[32m  }[m
[32m+[m[41m  [m
[32m+[m[32m  .form-group {[m
[32m+[m[32m    display: flex;[m
[32m+[m[32m    flex-direction: column;[m
[32m+[m[32m    gap: 8px;[m
[32m+[m[32m  }[m
[32m+[m[41m  [m
[32m+[m[32m  .form-group label {[m
[32m+[m[32m    color: #555;[m
[32m+[m[32m    font-weight: 500;[m
[32m+[m[32m  }[m
[32m+[m[41m  [m
[32m+[m[32m  .input-container {[m
[32m+[m[32m    position: relative;[m
[32m+[m[32m  }[m
[32m+[m[41m  [m
[32m+[m[32m  .input-container input {[m
[32m+[m[32m    width: 100%;[m
[32m+[m[32m    padding: 12px;[m
[32m+[m[32m    padding-right: 40px;[m
[32m+[m[32m    border: 1px solid #ddd;[m
[32m+[m[32m    border-radius: 8px;[m
[32m+[m[32m    font-size: 16px;[m
[32m+[m[32m    transition: border-color 0.3s;[m
[32m+[m[32m  }[m
[32m+[m[41m  [m
[32m+[m[32m  .input-container input:focus {[m
[32m+[m[32m    outline: none;[m
[32m+[m[32m    border-color: #1a73e8;[m
[32m+[m[32m  }[m
[32m+[m[41m  [m
[32m+[m[32m  .input-icon {[m
[32m+[m[32m    position: absolute;[m
[32m+[m[32m    right: 12px;[m
[32m+[m[32m    top: 50%;[m
[32m+[m[32m    transform: translateY(-50%);[m
[32m+[m[32m    background: none;[m
[32m+[m[32m    border: none;[m
[32m+[m[32m    cursor: pointer;[m
[32m+[m[32m    padding: 0;[m
[32m+[m[32m    color: #666;[m
[32m+[m[32m  }[m
[32m+[m[41m  [m
[32m+[m[32m  .sign-in-button {[m
[32m+[m[32m    margin-top: 16px;[m
[32m+[m[32m    padding: 12px;[m
[32m+[m[32m    background-color: #1a73e8;[m
[32m+[m[32m    color: white;[m
[32m+[m[32m    border: none;[m
[32m+[m[32m    border-radius: 8px;[m
[32m+[m[32m    font-size: 16px;[m
[32m+[m[32m    font-weight: 500;[m
[32m+[m[32m    cursor: pointer;[m
[32m+[m[32m    transition: background-color 0.3s;[m
[32m+[m[32m  }[m
[32m+[m[41m  [m
[32m+[m[32m  .sign-in-button:hover {[m
[32m+[m[32m    background-color: #1557b0;[m
[32m+[m[32m  }[m
\ No newline at end of file[m
[1mdiff --git a/frontend_LHB3/src/pages/Login.jsx b/frontend_LHB3/src/pages/Login.jsx[m
[1mnew file mode 100644[m
[1mindex 0000000..1c46b8b[m
[1m--- /dev/null[m
[1m+++ b/frontend_LHB3/src/pages/Login.jsx[m
[36m@@ -0,0 +1,144 @@[m
[32m+[m[32mimport React, { useState } from 'react';[m
[32m+[m[32mimport { useNavigate } from 'react-router-dom';[m
[32m+[m[32mimport './Login.css';[m
[32m+[m[32mimport * as assets from '../assets/assets';[m
[32m+[m
[32m+[m[32m// TODO: Backend Integration Comments:[m
[32m+[m
[32m+[m[32m// 1. Authentication API:[m
[32m+[m[32m// - Replace hardcoded login with real backend authentication[m
[32m+[m[32m// - Create API service in src/api/auth.js with login endpoint[m
[32m+[m[32m// - Send credentials to POST /api/auth/login[m[41m [m
[32m+[m[32m// - Expected response: { user: {...}, token: "jwt_token", refreshToken: "refresh_token" }[m
[32m+[m
[32m+[m[32m// 2. Error Handling:[m
[32m+[m[32m// - Handle various authentication errors:[m
[32m+[m[32m//   a) Invalid credentials (401)[m
[32m+[m[32m//   b) Account locked (403)[m
[32m+[m[32m//   c) Server errors (500)[m
[32m+[m[32m//   d) Network issues[m
[32m+[m[32m// - Display appropriate error messages to the user[m
[32m+[m
[32m+[m[32m// 3. Form Validation:[m
[32m+[m[32m// - Add client-side validation for email format[m
[32m+[m[32m// - Consider rate limiting login attempts on frontend[m
[32m+[m
[32m+[m[32m// 4. Token Storage:[m
[32m+[m[32m// - Store JWT token securely (HttpOnly cookies preferred)[m
[32m+[m[32m// - Save user data in AuthContext or global state[m
[32m+[m[32m// - Implement token refresh mechanism[m
[32m+[m
[32m+[m[32m// 5. Remember Me Functionality:[m
[32m+[m[32m// - Add a "Remember Me" checkbox if needed[m
[32m+[m[32m// - Store persistent login state only if explicitly requested[m
[32m+[m
[32m+[m[32m// 6. Security Enhancements:[m
[32m+[m[32m// - Consider implementing CAPTCHA for multiple failed attempts[m
[32m+[m[32m// - Add loading state during authentication[m
[32m+[m[32m// - Disable form submission while request is in progress[m
[32m+[m
[32m+[m[32mconst Login = ({ onLogin }) => {[m
[32m+[m[32m  const [email, setEmail] = useState('');[m
[32m+[m[32m  const [password, setPassword] = useState('');[m
[32m+[m[32m  const [showPassword, setShowPassword] = useState(false);[m
[32m+[m[32m  const navigate = useNavigate();[m
[32m+[m[41m  [m
[32m+[m[32m  const handleSubmit = (e) => {[m
[32m+[m[32m    e.preventDefault();[m
[32m+[m[32m    if (email === 'user@iitk.ac.in' && password === 'user123') {[m
[32m+[m[32m      console.log('User login successful');[m
[32m+[m[32m      if (onLogin) {[m
[32m+[m[32m        onLogin(email);[m
[32m+[m[32m      }[m
[32m+[m[32m    }[m
[32m+[m[32m    else if (email === 'admin@iitk.ac.in' && password === 'admin123') {[m
[32m+[m[32m      console.log('Admin login successful');[m
[32m+[m[32m      if (onLogin) {[m
[32m+[m[32m        onLogin(email);[m
[32m+[m[32m      }[m
[32m+[m[32m    }[m
[32m+[m[32m    else {[m
[32m+[m[32m      alert('Invalid credentials. Please try again.');[m
[32m+[m[32m    }[m
[32m+[m[32m  };[m
[32m+[m[41m  [m
[32m+[m[32m  return ([m
[32m+[m[32m    <div className="login-page">[m
[32m+[m[32m      <div className="login-container">[m
[32m+[m[32m        <div[m[41m [m
[32m+[m[32m          className="login-image-container"[m
[32m+[m[32m          style={{[m[41m [m
[32m+[m[32m            background: `linear-gradient(rgba(0, 0, 0, 0.5), rgba(0, 0, 0, 0.5)), url(${assets.assets.loginpageiitk})`,[m
[32m+[m[32m            backgroundSize: 'cover',[m
[32m+[m[32m            backgroundPosition: 'center'[m
[32m+[m[32m          }}[m
[32m+[m[32m        >[m
[32m+[m[32m          {/* The background image is set via inline style now */}[m
[32m+[m[32m        </div>[m
[32m+[m[41m        [m
[32m+[m[32m        <div className="login-form-container">[m
[32m+[m[32m          <div className="login-header">[m
[32m+[m[32m            <div className="logo-container">[m
[32m+[m[32m              <img[m
[32m+[m[32m                src={assets.assets.iitk_logo}[m
[32m+[m[32m                alt="IIT Kanpur Logo"[m
[32m+[m[32m                className="iit-logo"[m
[32m+[m[32m              />[m
[32m+[m[32m              <span>IIT Kanpur</span>[m
[32m+[m[32m            </div>[m
[32m+[m[32m          </div>[m
[32m+[m[41m          [m
[32m+[m[32m          <div className="login-form-content">[m
[32m+[m[32m            <h2>Book lecture hall</h2>[m
[32m+[m[32m            <h1>Sign In to LHB Portal</h1>[m
[32m+[m[41m            [m
[32m+[m[32m            <form onSubmit={handleSubmit} className="login-form">[m
[32m+[m[32m              <div className="form-group">[m
[32m+[m[32m                <label htmlFor="email">E-mail</label>[m
[32m+[m[32m                <div className="input-container">[m
[32m+[m[32m                  <input[m
[32m+[m[32m                    type="email"[m
[32m+[m[32m                    id="email"[m
[32m+[m[32m                    value={email}[m
[32m+[m[32m                    onChange={(e) => setEmail(e.target.value)}[m
[32m+[m[32m                    placeholder="example@iitk.ac.in"[m
[32m+[m[32m                    required[m
[32m+[m[32m                  />[m
[32m+[m[32m                  <span className="input-icon">📧</span>[m
[32m+[m[32m                </div>[m
[32m+[m[32m              </div>[m
[32m+[m[41m              [m
[32m+[m[32m              <div className="form-group">[m
[32m+[m[32m                <label htmlFor="password">Password</label>[m
[32m+[m[32m                <div className="input-container">[m
[32m+[m[32m                  <input[m
[32m+[m[32m                    type={showPassword ? "text" : "password"}[m
[32m+[m[32m                    id="password"[m
[32m+[m[32m                    value={password}[m
[32m+[m[32m                    onChange={(e) => setPassword(e.target.value)}[m
[32m+[m[32m                    placeholder="••••••••"[m
[32m+[m[32m                    autoComplete="current-password"[m
[32m+[m[32m                    required[m
[32m+[m[32m                  />[m
[32m+[m[32m                  <button[m
[32m+[m[32m                    type="button"[m
[32m+[m[32m                    className="input-icon clickable"[m
[32m+[m[32m                    onClick={() => setShowPassword(!showPassword)}[m
[32m+[m[32m                  >[m
[32m+[m[32m                    {showPassword ? "👁️" : "👁️‍🗨️"}[m
[32m+[m[32m                  </button>[m
[32m+[m[32m                </div>[m
[32m+[m[32m              </div>[m
[32m+[m[41m              [m
[32m+[m[32m              <button type="submit" className="sign-in-button">[m
[32m+[m[32m                Sign In[m
[32m+[m[32m              </button>[m
[32m+[m[32m            </form>[m
[32m+[m[32m          </div>[m
[32m+[m[32m        </div>[m
[32m+[m[32m      </div>[m
[32m+[m[32m    </div>[m
[32m+[m[32m  );[m
[32m+[m[32m};[m
[32m+[m
[32m+[m[32mexport default Login;[m
\ No newline at end of file[m
[1mdiff --git a/frontend_LHB3/src/pages/Request_Booking.css b/frontend_LHB3/src/pages/Request_Booking.css[m
[1mnew file mode 100644[m
[1mindex 0000000..94768e4[m
[1m--- /dev/null[m
[1m+++ b/frontend_LHB3/src/pages/Request_Booking.css[m
[36m@@ -0,0 +1,190 @@[m
[32m+[m[32m/* Main wrapper for proper alignment with sidebar */[m
[32m+[m[32m.main-content-wrapper {[m
[32m+[m[32m    display: flex;[m
[32m+[m[32m    flex-direction: column;[m
[32m+[m[32m    padding: 15px;[m
[32m+[m[32m    height: 100%;[m
[32m+[m[32m    flex: 1;[m
[32m+[m[32m  }[m
[32m+[m[41m  [m
[32m+[m[32m  /* Form container styles */[m
[32m+[m[32m  .booking-form-container {[m
[32m+[m[32m    background-color: white;[m
[32m+[m[32m    border-radius: 8px;[m
[32m+[m[32m    box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);[m
[32m+[m[32m    width: 100%;[m
[32m+[m[32m    padding: 30px;[m
[32m+[m[32m    margin: 10px auto;[m
[32m+[m[32m    flex: 1;[m
[32m+[m[32m  }[m
[32m+[m[41m  [m
[32m+[m[32m  /* Form styles */[m
[32m+[m[32m  .booking-form {[m
[32m+[m[32m    display: flex;[m
[32m+[m[32m    flex-direction: column;[m
[32m+[m[32m    gap: 20px;[m
[32m+[m[32m  }[m
[32m+[m[41m  [m
[32m+[m[32m  .form-group {[m
[32m+[m[32m    display: flex;[m
[32m+[m[32m    flex-direction: column;[m
[32m+[m[32m    gap: 8px;[m
[32m+[m[32m  }[m
[32m+[m[41m  [m
[32m+[m[32m  .form-control {[m
[32m+[m[32m    padding: 8px 12px;[m
[32m+[m[32m    border: 1px solid #ddd;[m
[32m+[m[32m    border-radius: 4px;[m
[32m+[m[32m    font-size: 14px;[m
[32m+[m[32m    width: 100%;[m
[32m+[m[32m  }[m
[32m+[m[41m  [m
[32m+[m[32m  .form-row {[m
[32m+[m[32m    display: flex;[m
[32m+[m[32m    gap: 20px;[m
[32m+[m[32m    align-items: flex-end;[m
[32m+[m[32m    flex-wrap: wrap;[m
[32m+[m[32m  }[m
[32m+[m[41m  [m
[32m+[m[32m  .form-column {[m
[32m+[m[32m    display: flex;[m
[32m+[m[32m    flex-direction: column;[m
[32m+[m[32m    gap: 8px;[m
[32m+[m[32m    flex: 1;[m
[32m+[m[32m    min-width: 200px;[m
[32m+[m[32m  }[m
[32m+[m[41m  [m
[32m+[m[32m  .date-time-controls {[m
[32m+[m[32m    display: flex;[m
[32m+[m[32m    gap: 10px;[m
[32m+[m[32m    width: 100%;[m
[32m+[m[32m  }[m
[32m+[m[41m  [m
[32m+[m[32m  .date-input {[m
[32m+[m[32m    padding: 8px;[m
[32m+[m[32m    border: 1px solid #ddd;[m
[32m+[m[32m    border-radius: 4px;[m
[32m+[m[32m    flex: 1;[m
[32m+[m[32m    min-width: 130px;[m
[32m+[m[32m  }[m
[32m+[m[41m  [m
[32m+[m[32m  .time-select {[m
[32m+[m[32m    padding: 8px;[m
[32m+[m[32m    border: 1px solid #ddd;[m
[32m+[m[32m    border-radius: 4px;[m
[32m+[m[32m    width: 100px;[m
[32m+[m[32m  }[m
[32m+[m[41m  [m
[32m+[m[32m  .duration-indicator {[m
[32m+[m[32m    padding: 8px 12px;[m
[32m+[m[32m    display: flex;[m
[32m+[m[32m    align-items: center;[m
[32m+[m[32m    color: #555;[m
[32m+[m[32m    white-space: nowrap;[m
[32m+[m[32m  }[m
[32m+[m[41m  [m
[32m+[m[32m  .availability-indicator {[m
[32m+[m[32m    padding: 8px 12px;[m
[32m+[m[32m    background-color: #e8f5e9;[m
[32m+[m[32m    color: #2e7d32;[m
[32m+[m[32m    border-radius: 4px;[m
[32m+[m[32m    font-weight: bold;[m
[32m+[m[32m    white-space: nowrap;[m
[32m+[m[32m  }[m
[32m+[m[41m  [m
[32m+[m[32m  /* Section header with badge */[m
[32m+[m[32m  .section-header {[m
[32m+[m[32m    display: flex;[m
[32m+[m[32m    align-items: center;[m
[32m+[m[32m    gap: 10px;[m
[32m+[m[32m  }[m
[32m+[m[41m  [m
[32m+[m[32m  .badge {[m
[32m+[m[32m    background-color: #f0f0f0;[m
[32m+[m[32m    border-radius: 50%;[m
[32m+[m[32m    width: 20px;[m
[32m+[m[32m    height: 20px;[m
[32m+[m[32m    display: flex;[m
[32m+[m[32m    align-items: center;[m
[32m+[m[32m    justify-content: center;[m
[32m+[m[32m    font-size: 12px;[m
[32m+[m[32m  }[m
[32m+[m[41m  [m
[32m+[m[32m  .add-btn {[m
[32m+[m[32m    margin-left: auto;[m
[32m+[m[32m    background: transparent;[m
[32m+[m[32m    border: none;[m
[32m+[m[32m    color: #1a73e8;[m
[32m+[m[32m    cursor: pointer;[m
[32m+[m[32m    display: flex;[m
[32m+[m[32m    align-items: center;[m
[32m+[m[32m    gap: 4px;[m
[32m+[m[32m  }[m
[32m+[m[41m  [m
[32m+[m[32m  /* Hall selection */[m
[32m+[m[32m  .hall-selection {[m
[32m+[m[32m    margin-top: 8px;[m
[32m+[m[32m  }[m
[32m+[m[41m  [m
[32m+[m[32m  .selected-hall {[m
[32m+[m[32m    display: inline-flex;[m
[32m+[m[32m    align-items: center;[m
[32m+[m[32m    background-color: #f0f5ff;[m
[32m+[m[32m    padding: 8px 12px;[m
[32m+[m[32m    border-radius: 4px;[m
[32m+[m[32m    border: 1px solid #dce6fb;[m
[32m+[m[32m    gap: 5px;[m
[32m+[m[32m  }[m
[32m+[m[41m  [m
[32m+[m[32m  .info-icon {[m
[32m+[m[32m    color: #1a73e8;[m
[32m+[m[32m    cursor: pointer;[m
[32m+[m[32m  }[m
[32m+[m[41m  [m
[32m+[m[32m  /* Circle icon for add buttons */[m
[32m+[m[32m  .circle-icon {[m
[32m+[m[32m    display: inline-flex;[m
[32m+[m[32m    align-items: center;[m
[32m+[m[32m    justify-content: center;[m
[32m+[m[32m    width: 18px;[m
[32m+[m[32m    height: 18px;[m
[32m+[m[32m    border-radius: 50%;[m
[32m+[m[32m    background-color: #fff;[m
[32m+[m[32m    color: #333;[m
[32m+[m[32m    font-size: 16px;[m
[32m+[m[32m    line-height: 1;[m
[32m+[m[32m  }[m
[32m+[m[41m  [m
[32m+[m[32m  /* Form actions */[m
[32m+[m[32m  .form-actions {[m
[32m+[m[32m    display: flex;[m
[32m+[m[32m    justify-content: flex-end;[m
[32m+[m[32m    margin-top: 20px;[m
[32m+[m[32m  }[m
[32m+[m[41m  [m
[32m+[m[32m  .submit-btn {[m
[32m+[m[32m    background-color: #1a73e8;[m
[32m+[m[32m    color: white;[m
[32m+[m[32m    border: none;[m
[32m+[m[32m    border-radius: 4px;[m
[32m+[m[32m    padding: 10px 24px;[m
[32m+[m[32m    font-weight: bold;[m
[32m+[m[32m    cursor: pointer;[m
[32m+[m[32m    text-transform: uppercase;[m
[32m+[m[32m  }[m
[32m+[m[41m  [m
[32m+[m[32m  .submit-btn:hover {[m
[32m+[m[32m    background-color: #1565c0;[m
[32m+[m[32m  }[m
[32m+[m[41m  [m
[32m+[m[32m  /* Mobile responsiveness */[m
[32m+[m[32m  @media (max-width: 768px) {[m
[32m+[m[32m    .form-row {[m
[32m+[m[32m      flex-direction: column;[m
[32m+[m[32m      gap: 10px;[m
[32m+[m[32m    }[m
[32m+[m[41m    [m
[32m+[m[32m    .booking-form-container {[m
[32m+[m[32m      padding: 15px;[m
[32m+[m[32m    }[m
[32m+[m[32m  }[m
\ No newline at end of file[m
[1mdiff --git a/frontend_LHB3/src/pages/Request_Booking.jsx b/frontend_LHB3/src/pages/Request_Booking.jsx[m
[1mnew file mode 100644[m
[1mindex 0000000..b5a80ea[m
[1m--- /dev/null[m
[1m+++ b/frontend_LHB3/src/pages/Request_Booking.jsx[m
[36m@@ -0,0 +1,270 @@[m
[32m+[m[32m// TODO: Backend Integration Comments:[m
[32m+[m
[32m+[m[32m// 1. State Management:[m
[32m+[m[32m// - Add useState hooks to manage form state for all booking details[m
[32m+[m[32m// - Example: const [formData, setFormData] = useState({ hall: '', date: '', startTime: '', endTime: '', purpose: '', additionalEquipment: '' })[m
[32m+[m
[32m+[m[32m// 2. API Integration Points:[m
[32m+[m[32m// - Import axios: import axios from 'axios'[m
[32m+[m[32m// - Create API service file at: src/services/api.js with all endpoint definitions[m
[32m+[m[32m// - Base API URL should be configurable via environment variable[m
[32m+[m
[32m+[m[32m// 3. Required API Endpoints:[m
[32m+[m[32m// - GET /api/halls - Fetch available lecture halls[m
[32m+[m[32m// - GET /api/halls/{hallId}/availability?date={date} - Check hall availability for specific date[m
[32m+[m[32m// - POST /api/bookings - Submit a new booking request[m
[32m+[m[32m// - GET /api/user/profile - Get user details for pre-filling the form[m
[32m+[m
[32m+[m[32m// 4. Form Submission:[m
[32m+[m[32m// - Create handleSubmit function to:[m
[32m+[m[32m//   a) Validate all required fields[m
[32m+[m[32m//   b) Format data in the structure expected by backend[m
[32m+[m[32m//   c) Make POST request to /api/bookings[m
[32m+[m[32m//   d) Handle success/error responses[m
[32m+[m[32m//   e) Show appropriate user feedback[m
[32m+[m
[32m+[m[32m// 5. Form Validation:[m
[32m+[m[32m// - Add client-side validation before submission[m
[32m+[m[32m// - Check for required fields, date/time format, conflicts[m
[32m+[m[32m// - Show validation errors next to respective fields[m
[32m+[m
[32m+[m[32m// 6. Loading States:[m
[32m+[m[32m// - Add loading states for initial data fetch[m
[32m+[m[32m// - Show spinner during form submission[m
[32m+[m[32m// - Disable submit button while processing[m
[32m+[m
[32m+[m[32m// 7. Error Handling:[m
[32m+[m[32m// - Try/catch blocks around all API calls[m
[32m+[m[32m// - Display user-friendly error messages[m
[32m+[m[32m// - Log detailed errors for debugging[m
[32m+[m
[32m+[m[32m// 8. Success Handling:[m
[32m+[m[32m// - Redirect to status page after successful booking[m
[32m+[m[32m// - Or show success message with booking ID[m
[32m+[m[32m// - Provide option to create another booking[m
[32m+[m
[32m+[m[32m// 9. Authentication:[m
[32m+[m[32m// - Include authentication headers in all API requests[m
[32m+[m[32m// - Check user permissions before allowing submission[m
[32m+[m[32m// - Redirect to login if auth token is expired[m
[32m+[m
[32m+[m[32mimport React, { useState } from 'react';[m
[32m+[m[32mimport './Request_Booking.css';[m
[32m+[m
[32m+[m[32mconst Request_Booking = () => {[m
[32m+[m[32m  // State for form fields[m
[32m+[m[32m  const [purpose, setPurpose] = useState('');[m
[32m+[m[32m  const [startDate, setStartDate] = useState('');[m
[32m+[m[32m  const [startTime, setStartTime] = useState('8:00 AM');[m
[32m+[m[32m  const [endDate, setEndDate] = useState('');[m
[32m+[m[32m  const [endTime, setEndTime] = useState('8:30 AM');[m
[32m+[m[32m  const [repeatOption, setRepeatOption] = useState('Does Not Repeat');[m
[32m+[m[32m  const [selectedHall, setSelectedHall] = useState('LH18');[m
[32m+[m[32m  const [capacity, setCapacity] = useState('');[m
[32m+[m[32m  const [accessories, setAccessories] = useState([]);[m
[32m+[m[41m  [m
[32m+[m[32m  // Time options for dropdowns[m
[32m+[m[32m  const timeOptions = [[m
[32m+[m[32m    '8:00 AM', '8:30 AM', '9:00 AM', '9:30 AM', '10:00 AM', '10:30 AM',[m
[32m+[m[32m    '11:00 AM', '11:30 AM', '12:00 PM', '12:30 PM', '1:00 PM', '1:30 PM',[m
[32m+[m[32m    '2:00 PM', '2:30 PM', '3:00 PM', '3:30 PM', '4:00 PM', '4:30 PM',[m
[32m+[m[32m    '5:00 PM', '5:30 PM', '6:00 PM'[m
[32m+[m[32m  ];[m
[32m+[m
[32m+[m[32m  // Repeat options[m
[32m+[m[32m  const repeatOptions = [[m
[32m+[m[32m    'Does Not Repeat', 'Daily', 'Weekly', 'Monthly'[m
[32m+[m[32m  ];[m
[32m+[m
[32m+[m[32m  // Hall options[m
[32m+[m[32m  const hallOptions = ['LH18', 'LH19', 'LH20', 'LH21'];[m
[32m+[m
[32m+[m[32m  // Capacity options[m
[32m+[m[32m  const capacityOptions = [[m
[32m+[m[32m    '30', '50', '100', '150', '200'[m
[32m+[m[32m  ];[m
[32m+[m
[32m+[m[32m  // Accessories options[m
[32m+[m[32m  const accessoryOptions = [[m
[32m+[m[32m    'Projector', 'Microphone', 'Whiteboard', 'Computer', 'Speaker System'[m
[32m+[m[32m  ];[m
[32m+[m
[32m+[m[32m  // Calculate duration between start and end time[m
[32m+[m[32m  const calculateDuration = () => {[m
[32m+[m[32m    if (!startTime || !endTime) return '';[m
[32m+[m[41m    [m
[32m+[m[32m    // Simple calculation for demo purposes[m
[32m+[m[32m    return '30 minutes';[m
[32m+[m[32m  };[m
[32m+[m
[32m+[m[32m  // Handle form submission[m
[32m+[m[32m  const handleSubmit = (e) => {[m
[32m+[m[32m    e.preventDefault();[m
[32m+[m[32m    alert('Booking submitted!');[m
[32m+[m[32m    // In a real application, you would send this data to your backend[m
[32m+[m[32m  };[m
[32m+[m
[32m+[m[32m  // Handle add hall[m
[32m+[m[32m  const handleAddHall = () => {[m
[32m+[m[32m    alert('Feature to add another hall would be implemented here');[m
[32m+[m[32m  };[m
[32m+[m
[32m+[m[32m  // Handle add accessory[m
[32m+[m[32m  const handleAddAccessory = () => {[m
[32m+[m[32m    alert('Feature to add accessories would be implemented here');[m
[32m+[m[32m  };[m
[32m+[m
[32m+[m[32m  return ([m
[32m+[m[32m    <div className="main-content-wrapper">[m
[32m+[m[32m      <div className="booking-form-container">[m
[32m+[m[32m        <form className="booking-form" onSubmit={handleSubmit}>[m
[32m+[m[32m          <div className="form-group">[m
[32m+[m[32m            <label htmlFor="purpose">Purpose</label>[m
[32m+[m[32m            <input[m[41m [m
[32m+[m[32m              type="text"[m[41m [m
[32m+[m[32m              id="purpose"[m[41m [m
[32m+[m[32m              value={purpose}[m[41m [m
[32m+[m[32m              onChange={(e) => setPurpose(e.target.value)}[m[41m [m
[32m+[m[32m              placeholder="Linux Session Y-24"[m
[32m+[m[32m              className="form-control"[m
[32m+[m[32m            />[m
[32m+[m[32m          </div>[m
[32m+[m
[32m+[m[32m          <div className="form-group">[m
[32m+[m[32m            <label htmlFor="user">user</label>[m
[32m+[m[32m            <input[m[41m [m
[32m+[m[32m              type="text"[m[41m [m
[32m+[m[32m              id="user"[m[41m [m
[32m+[m[32m              value="Pclub IITK"[m[41m [m
[32m+[m[32m              readOnly[m[41m [m
[32m+[m[32m              className="form-control"[m
[32m+[m[32m            />[m
[32m+[m[32m          </div>[m
[32m+[m
[32m+[m[32m          <div className="form-row">[m
[32m+[m[32m            <div className="form-column">[m
[32m+[m[32m              <label>Begin</label>[m
[32m+[m[32m              <div className="date-time-controls">[m
[32m+[m[32m                <input[m[41m [m
[32m+[m[32m                  type="date"[m[41m [m
[32m+[m[32m                  value={startDate}[m[41m [m
[32m+[m[32m                  onChange={(e) => setStartDate(e.target.value)}[m[41m [m
[32m+[m[32m                  className="date-input"[m
[32m+[m[32m                  placeholder="dd-mm-yyyy"[m
[32m+[m[32m                />[m
[32m+[m[32m                <select[m[41m [m
[32m+[m[32m                  value={startTime}[m[41m [m
[32m+[m[32m                  onChange={(e) => setStartTime(e.target.value)}[m
[32m+[m[32m                  className="time-select"[m
[32m+[m[32m                >[m
[32m+[m[32m                  {timeOptions.map(time => ([m
[32m+[m[32m                    <option key={`start-${time}`} value={time}>{time}</option>[m
[32m+[m[32m                  ))}[m
[32m+[m[32m                </select>[m
[32m+[m[32m              </div>[m
[32m+[m[32m            </div>[m
[32m+[m
[32m+[m[32m            <div className="form-column">[m
[32m+[m[32m              <label>End</label>[m
[32m+[m[32m              <div className="date-time-controls">[m
[32m+[m[32m                <input[m[41m [m
[32m+[m[32m                  type="date"[m[41m [m
[32m+[m[32m                  value={endDate}[m[41m [m
[32m+[m[32m                  onChange={(e) => setEndDate(e.target.value)}[m[41m [m
[32m+[m[32m                  className="date-input"[m
[32m+[m[32m                  placeholder="dd-mm-yyyy"[m
[32m+[m[32m                />[m
[32m+[m[32m                <select[m[41m [m
[32m+[m[32m                  value={endTime}[m[41m [m
[32m+[m[32m                  onChange={(e) => setEndTime(e.target.value)}[m
[32m+[m[32m                  className="time-select"[m
[32m+[m[32m                >[m
[32m+[m[32m                  {timeOptions.map(time => ([m
[32m+[m[32m                    <option key={`end-${time}`} value={time}>{time}</option>[m
[32m+[m[32m                  ))}[m
[32m+[m[32m                </select>[m
[32m+[m[32m              </div>[m
[32m+[m[32m            </div>[m
[32m+[m
[32m+[m[32m            <div className="duration-indicator">[m
[32m+[m[32m              {calculateDuration()}[m
[32m+[m[32m            </div>[m
[32m+[m
[32m+[m[32m            <div className="availability-indicator">[m
[32m+[m[32m              Available[m
[32m+[m[32m            </div>[m
[32m+[m[32m          </div>[m
[32m+[m
[32m+[m[32m          <div className="form-group">[m
[32m+[m[32m            <label>Repeat</label>[m
[32m+[m[32m            <select[m[41m [m
[32m+[m[32m              value={repeatOption}[m[41m [m
[32m+[m[32m              onChange={(e) => setRepeatOption(e.target.value)}[m
[32m+[m[32m              className="form-control"[m
[32m+[m[32m            >[m
[32m+[m[32m              {repeatOptions.map(option => ([m
[32m+[m[32m                <option key={option} value={option}>{option}</option>[m
[32m+[m[32m              ))}[m
[32m+[m[32m            </select>[m
[32m+[m[32m          </div>[m
[32m+[m
[32m+[m[32m          <div className="form-group">[m
[32m+[m[32m            <div className="section-header">[m
[32m+[m[32m              <label>Lecture Hall</label>[m
[32m+[m[32m              <span className="badge">1</span>[m
[32m+[m[32m              <button[m[41m [m
[32m+[m[32m                type="button"[m[41m [m
[32m+[m[32m                className="add-btn"[m
[32m+[m[32m                onClick={handleAddHall}[m
[32m+[m[32m              >[m
[32m+[m[32m                Add <span className="circle-icon">⊕</span>[m
[32m+[m[32m              </button>[m
[32m+[m[32m            </div>[m
[32m+[m[32m            <div className="hall-selection">[m
[32m+[m[32m              <div className="selected-hall">[m
[32m+[m[32m                {selectedHall} <span className="info-icon">ⓘ</span>[m
[32m+[m[32m              </div>[m
[32m+[m[32m            </div>[m
[32m+[m[32m          </div>[m
[32m+[m
[32m+[m[32m          <div className="form-group">[m
[32m+[m[32m            <div className="section-header">[m
[32m+[m[32m              <label>Capacity</label>[m
[32m+[m[32m              <span className="badge">0</span>[m
[32m+[m[32m            </div>[m
[32m+[m[32m            <select[m[41m [m
[32m+[m[32m              value={capacity}[m[41m [m
[32m+[m[32m              onChange={(e) => setCapacity(e.target.value)}[m
[32m+[m[32m              className="form-control"[m
[32m+[m[32m            >[m
[32m+[m[32m              <option value="">Select capacity</option>[m
[32m+[m[32m              {capacityOptions.map(option => ([m
[32m+[m[32m                <option key={option} value={option}>{option}</option>[m
[32m+[m[32m              ))}[m
[32m+[m[32m            </select>[m
[32m+[m[32m          </div>[m
[32m+[m
[32m+[m[32m          <div className="form-group">[m
[32m+[m[32m            <div className="section-header">[m
[32m+[m[32m              <label>Accessories</label>[m
[32m+[m[32m              <span className="badge">0</span>[m
[32m+[m[32m              <button[m[41m [m
[32m+[m[32m                type="button"[m[41m [m
[32m+[m[32m                className="add-btn"[m
[32m+[m[32m                onClick={handleAddAccessory}[m
[32m+[m[32m              >[m
[32m+[m[32m                Add <span className="circle-icon">⊕</span>[m
[32m+[m[32m              </button>[m
[32m+[m[32m            </div>[m
[32m+[m[32m          </div>[m
[32m+[m
[32m+[m[32m          <div className="form-actions">[m
[32m+[m[32m            <button type="submit" className="submit-btn">SUBMIT</button>[m
[32m+[m[32m          </div>[m
[32m+[m[32m        </form>[m
[32m+[m[32m      </div>[m
[32m+[m[32m    </div>[m
[32m+[m[32m  );[m
[32m+[m[32m};[m
[32m+[m
[32m+[m[32mexport default Request_Booking;[m
\ No newline at end of file[m
[1mdiff --git a/frontend_LHB3/src/pages/Status.jsx b/frontend_LHB3/src/pages/Status.jsx[m
[1mnew file mode 100644[m
[1mindex 0000000..392bf1c[m
[1m--- /dev/null[m
[1m+++ b/frontend_LHB3/src/pages/Status.jsx[m
[36m@@ -0,0 +1,44 @@[m
[32m+[m[32mimport React from 'react'[m
[32m+[m
[32m+[m[32m// TODO: Backend Integration Comments:[m
[32m+[m
[32m+[m[32m// 1. Status Data Fetching:[m
[32m+[m[32m// - Implement API calls to fetch booking status[m
[32m+[m[32m// - Create src/api/bookings.js with status endpoints[m
[32m+[m[32m// - Call GET /api/bookings/status or GET /api/bookings?status=pending[m
[32m+[m[32m// - Group bookings by status (pending, approved, rejected)[m
[32m+[m
[32m+[m[32m// 2. UI Implementation:[m
[32m+[m[32m// - Replace placeholder with actual status UI[m
[32m+[m[32m// - Show booking details, current status, and timestamps[m
[32m+[m[32m// - Add visual indicators for different statuses (colors, icons)[m
[32m+[m[32m// - Implement empty states for when no bookings exist[m
[32m+[m
[32m+[m[32m// 3. Real-time Updates:[m
[32m+[m[32m// - Consider WebSocket implementation for status changes[m
[32m+[m[32m// - Update UI when booking status changes without refresh[m
[32m+[m[32m// - Add notifications for status changes[m
[32m+[m
[32m+[m[32m// 4. Action Buttons:[m
[32m+[m[32m// - Add actions based on current status:[m
[32m+[m[32m//   a) Cancel booking if pending[m
[32m+[m[32m//   b) View details[m
[32m+[m[32m//   c) Resubmit if rejected with reasons[m
[32m+[m
[32m+[m[32m// 5. Filtering and Sorting:[m
[32m+[m[32m// - Allow filtering by status, date, hall[m
[32m+[m[32m// - Implement sorting options (newest first, by status)[m
[32m+[m[32m// - Persist filter/sort preferences[m
[32m+[m
[32m+[m[32m// 6. Pagination:[m
[32m+[m[32m// - Implement if number of bookings is large[m
[32m+[m[32m// - Use limit/offset or page-based pagination[m
[32m+[m[32m// - Add infinite scrolling or load more button[m
[32m+[m
[32m+[m[32mconst Status = () => {[m
[32m+[m[32m  return ([m
[32m+[m[32m    <div>L lage hai, chaiye?</div>[m
[32m+[m[32m  )[m
[32m+[m[32m}[m
[32m+[m
[32m+[m[32mexport default Status[m
\ No newline at end of file[m
[1mdiff --git a/frontend_LHB3/src/pages/UserHistory.jsx b/frontend_LHB3/src/pages/UserHistory.jsx[m
[1mnew file mode 100644[m
[1mindex 0000000..bfb5098[m
[1m--- /dev/null[m
[1m+++ b/frontend_LHB3/src/pages/UserHistory.jsx[m
[36m@@ -0,0 +1,219 @@[m
[32m+[m[32mimport React, { useState, useEffect } from 'react';[m
[32m+[m[32mimport './History.css';[m
[32m+[m
[32m+[m[32m// TODO: Backend Integration Comments:[m
[32m+[m
[32m+[m[32m// 1. History Data Fetching:[m
[32m+[m[32m// - Replace sample data with API calls[m
[32m+[m[32m// - Create src/api/bookings.js with history endpoints[m
[32m+[m[32m// - Call GET /api/bookings/history?month={month}&year={year}[m[41m [m
[32m+[m[32m// - Add pagination if the number of bookings is large[m
[32m+[m
[32m+[m[32m// 2. Data Structure:[m
[32m+[m[32m// - Adapt component to match backend data structure[m
[32m+[m[32m// - Expected response: { bookings: [...], totalAmount: number }[m
[32m+[m[32m// - Handle empty response gracefully[m
[32m+[m
[32m+[m[32m// 3. Download Functionality:[m
[32m+[m[32m// - Implement booking receipt/invoice download[m
[32m+[m[32m// - Call GET /api/bookings/{id}/receipt with proper authorization[m
[32m+[m[32m// - Support multiple formats (PDF, CSV) if needed[m
[32m+[m
[32m+[m[32m// 4. Cancellation/Modification:[m
[32m+[m[32m// - Add ability to cancel bookings if status allows[m
[32m+[m[32m// - Implement POST /api/bookings/{id}/cancel[m
[32m+[m[32m// - Add modification functionality where applicable[m
[32m+[m
[32m+[m[32m// 5. Date Navigation:[m
[32m+[m[32m// - Send month/year parameters to backend when navigation changes[m
[32m+[m[32m// - Optimize to prevent unnecessary API calls[m
[32m+[m[32m// - Add loading states during data fetching[m
[32m+[m
[32m+[m[32m// 6. Error Handling:[m
[32m+[m[32m// - Display user-friendly error messages[m
[32m+[m[32m// - Implement retry mechanism for failed requests[m
[32m+[m[32m// - Log errors to monitoring service[m
[32m+[m
[32m+[m[32mconst UserHistory = () => {[m
[32m+[m[32m  // Sample booking history data organized by month[m[41m [m
[32m+[m[32m  // Just to check and show the working of the navigation button[m
[32m+[m[32m  const allBookings = {[m
[32m+[m[32m    // January data[m
[32m+[m[32m    '0-2025': [[m
[32m+[m[32m      {[m
[32m+[m[32m        id: 1,[m
[32m+[m[32m        purpose: 'Intro Session ML',[m
[32m+[m[32m        date: '12-01-25',[m
[32m+[m[32m        time: '9:00 AM - 11:00 AM',[m
[32m+[m[32m        lectureHall: 'LH07',[m
[32m+[m[32m        amount: 6000[m
[32m+[m[32m      },[m
[32m+[m[32m      {[m
[32m+[m[32m        id: 2,[m
[32m+[m[32m        purpose: 'Contest',[m
[32m+[m[32m        date: '03-01-25',[m
[32m+[m[32m        time: '5:00 PM - 7:00 PM',[m
[32m+[m[32m        lectureHall: 'LH03',[m
[32m+[m[32m        amount: 6000[m
[32m+[m[32m      },[m
[32m+[m[32m      {[m
[32m+[m[32m        id: 3,[m
[32m+[m[32m        purpose: 'Workshop Web-development',[m
[32m+[m[32m        date: '07-01-25',[m
[32m+[m[32m        time: '6:00 PM - 7:00 PM',[m
[32m+[m[32m        lectureHall: 'LH07',[m
[32m+[m[32m        amount: 3500[m
[32m+[m[32m      }[m
[32m+[m[32m    ],[m
[32m+[m[32m    // February data[m
[32m+[m[32m    '1-2025': [[m
[32m+[m[32m      {[m
[32m+[m[32m        id: 4,[m
[32m+[m[32m        purpose: 'AI Workshop',[m
[32m+[m[32m        date: '05-02-25',[m
[32m+[m[32m        time: '2:00 PM - 4:00 PM',[m
[32m+[m[32m        lectureHall: 'LH01',[m
[32m+[m[32m        amount: 4500[m
[32m+[m[32m      },[m
[32m+[m[32m      {[m
[32m+[m[32m        id: 5,[m
[32m+[m[32m        purpose: 'Hackathon Intro',[m
[32m+[m[32m        date: '14-02-25',[m
[32m+[m[32m        time: '10:00 AM - 12:00 PM',[m
[32m+[m[32m        lectureHall: 'LH05',[m
[32m+[m[32m        amount: 5000[m
[32m+[m[32m      }[m
[32m+[m[32m    ],[m
[32m+[m[32m    // March data[m
[32m+[m[32m    '2-2025': [[m
[32m+[m[32m      {[m
[32m+[m[32m        id: 6,[m
[32m+[m[32m        purpose: 'Project Showcase',[m
[32m+[m[32m        date: '10-03-25',[m
[32m+[m[32m        time: '3:00 PM - 5:00 PM',[m
[32m+[m[32m        lectureHall: 'LH02',[m
[32m+[m[32m        amount: 7000[m
[32m+[m[32m      },[m
[32m+[m[32m      {[m
[32m+[m[32m        id: 7,[m
[32m+[m[32m        purpose: 'Guest Lecture',[m
[32m+[m[32m        date: '22-03-25',[m
[32m+[m[32m        time: '1:00 PM - 3:00 PM',[m
[32m+[m[32m        lectureHall: 'LH08',[m
[32m+[m[32m        amount: 8500[m
[32m+[m[32m      }[m
[32m+[m[32m    ],[m
[32m+[m[32m    // April data[m
[32m+[m[32m    '3-2025': [[m
[32m+[m[32m      {[m
[32m+[m[32m        id: 8,[m
[32m+[m[32m        purpose: 'Web3 Workshop',[m
[32m+[m[32m        date: '08-04-25',[m
[32m+[m[32m        time: '4:00 PM - 6:00 PM',[m
[32m+[m[32m        lectureHall: 'LH06',[m
[32m+[m[32m        amount: 5500[m
[32m+[m[32m      }[m
[32m+[m[32m    ][m
[32m+[m[32m  };[m
[32m+[m
[32m+[m[32m  // State for current month and year (starting with January 2025)[m
[32m+[m[32m  const [currentMonth, setCurrentMonth] = useState(0); // 0 = January, 1 = February, etc.[m
[32m+[m[32m  const [currentYear, setCurrentYear] = useState(2025);[m
[32m+[m[32m  const [bookings, setBookings] = useState([]);[m
[32m+[m[41m  [m
[32m+[m[32m  // Month names array[m
[32m+[m[32m  const monthNames = [[m
[32m+[m[32m    'JANUARY', 'FEBRUARY', 'MARCH', 'APRIL', 'MAY', 'JUNE',[m[41m [m
[32m+[m[32m    'JULY', 'AUGUST', 'SEPTEMBER', 'OCTOBER', 'NOVEMBER', 'DECEMBER'[m
[32m+[m[32m  ];[m
[32m+[m
[32m+[m[32m  // Update bookings when month/year changes[m
[32m+[m[32m  useEffect(() => {[m
[32m+[m[32m    const key = `${currentMonth}-${currentYear}`;[m
[32m+[m[32m    setBookings(allBookings[key] || []);[m
[32m+[m[32m  }, [currentMonth, currentYear]);[m
[32m+[m[41m  [m
[32m+[m[32m  // Calculate total amount[m
[32m+[m[32m  const totalAmount = bookings.reduce((sum, booking) => sum + booking.amount, 0);[m
[32m+[m
[32m+[m[32m  // Function to handle month navigation[m
[32m+[m[32m  const navigateMonth = (direction) => {[m
[32m+[m[32m    //Here we typically do console.log() to send the data to the backend[m
[32m+[m[32m    //console.log(`Navigating to ${direction} month`);[m
[32m+[m[32m    if (direction === 'next') {[m
[32m+[m[32m      if (currentMonth === 11) {[m
[32m+[m[32m        setCurrentMonth(0);[m
[32m+[m[32m        setCurrentYear(currentYear + 1);[m
[32m+[m[32m      } else {[m
[32m+[m[32m        setCurrentMonth(currentMonth + 1);[m
[32m+[m[32m      }[m
[32m+[m[32m    } else if (direction === 'prev') {[m
[32m+[m[32m      if (currentMonth === 0) {[m
[32m+[m[32m        setCurrentMonth(11);[m
[32m+[m[32m        setCurrentYear(currentYear - 1);[m
[32m+[m[32m      } else {[m
[32m+[m[32m        setCurrentMonth(currentMonth - 1);[m
[32m+[m[32m      }[m
[32m+[m[32m    }[m
[32m+[m[32m  };[m
[32m+[m
[32m+[m[32m  return ([m
[32m+[m[32m    <div className="history-container">[m
[32m+[m[32m      <h2 className="history-title">[m
[32m+[m[32m        <div className="month-navigation">[m
[32m+[m[32m          <button onClick={() => navigateMonth('prev')} className="nav-button">&lt;</button>[m
[32m+[m[32m          <span>{monthNames[currentMonth]} {currentYear}</span>[m
[32m+[m[32m          <button onClick={() => navigateMonth('next')} className="nav-button">&gt;</button>[m
[32m+[m[32m        </div>[m
[32m+[m[32m      </h2>[m
[32m+[m[41m      [m
[32m+[m[32m      <div className="bookings-section">[m
[32m+[m[32m        <h3>Bookings for the Month of {monthNames[currentMonth]} {currentYear}</h3>[m
[32m+[m[41m        [m
[32m+[m[32m        {bookings.length > 0 ? ([m
[32m+[m[32m          <>[m
[32m+[m[32m            <div className="bookings-table">[m
[32m+[m[32m              <div className="table-header">[m
[32m+[m[32m                <div className="header-cell purpose">Purpose</div>[m
[32m+[m[32m                <div className="header-cell date">Date</div>[m
[32m+[m[32m                <div className="header-cell time">Time</div>[m
[32m+[m[32m                <div className="header-cell hall">Lecture Hall</div>[m
[32m+[m[32m                <div className="header-cell amount">Amount</div>[m
[32m+[m[32m                <div className="header-cell download"></div>[m
[32m+[m[32m              </div>[m
[32m+[m[41m              [m
[32m+[m[32m              {bookings.map(booking => ([m
[32m+[m[32m                <div key={booking.id} className="table-row">[m
[32m+[m[32m                  <div className="cell purpose">{booking.purpose}</div>[m
[32m+[m[32m                  <div className="cell date">{booking.date}</div>[m
[32m+[m[32m                  <div className="cell time">{booking.time}</div>[m
[32m+[m[32m                  <div className="cell hall">{booking.lectureHall}</div>[m
[32m+[m[32m                  <div className="cell amount">{booking.amount}</div>[m
[32m+[m[32m                  <div className="cell download">[m
[32m+[m[32m                    <button className="download-button">[m
[32m+[m[32m                      <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round">[m
[32m+[m[32m                        <path d="M21 15v4a2 2 0 01-2 2H5a2 2 0 01-2-2v-4"></path>[m
[32m+[m[32m                        <polyline points="7 10 12 15 17 10"></polyline>[m
[32m+[m[32m                        <line x1="12" y1="15" x2="12" y2="3"></line>[m
[32m+[m[32m                      </svg>[m
[32m+[m[32m                    </button>[m
[32m+[m[32m                  </div>[m
[32m+[m[32m                </div>[m
[32m+[m[32m              ))}[m
[32m+[m[32m            </div>[m
[32m+[m[41m            [m
[32m+[m[32m            <div className="total-section">[m
[32m+[m[32m              <span>Total: {totalAmount}</span>[m
[32m+[m[32m            </div>[m
[32m+[m[32m          </>[m
[32m+[m[32m        ) : ([m
[32m+[m[32m          <div className="no-bookings">[m
[32m+[m[32m            <p>No bookings found for this month.</p>[m
[32m+[m[32m          </div>[m
[32m+[m[32m        )}[m
[32m+[m[32m      </div>[m
[32m+[m[32m    </div>[m
[32m+[m[32m  );[m
[32m+[m[32m};[m
[32m+[m
[32m+[m[32mexport default UserHistory;[m
\ No newline at end of file[m
[1mdiff --git a/frontend_LHB3/vite.config.js b/frontend_LHB3/vite.config.js[m
[1mnew file mode 100644[m
[1mindex 0000000..ea837a2[m
[1m--- /dev/null[m
[1m+++ b/frontend_LHB3/vite.config.js[m
[36m@@ -0,0 +1,8 @@[m
[32m+[m[32mimport { defineConfig } from 'vite'[m
[32m+[m[32mimport react from '@vitejs/plugin-react'[m
[32m+[m[32mimport tailwindcss from '@tailwindcss/vite'[m
[32m+[m
[32m+[m[32m// https://vite.dev/config/[m
[32m+[m[32mexport default defineConfig({[m
[32m+[m[32m  plugins: [react(),tailwindcss()],[m
[32m+[m[32m})[m
