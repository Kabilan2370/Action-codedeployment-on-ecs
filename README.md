### What is Unleash – Feature Flag Management?
Unleash is an open-source, powerful feature management platform that helps development teams control feature releases, enabling gradual rollouts, A/B testing, kill switches, and personalized user experiences without redeploying code. **Unleash lets you turn application features ON or OFF without redeploying your app.**

### How it Works:
**1. Define Flag     :** Create a feature flag (e.g., "new-checkout-flow") in the Unleash dashboard.
**2. Set Strategy    :** Configure rules (e.g., enable for 10% of users, or users with specific IDs).
**3. Integrate SDK   :** Add the Unleash SDK to your application code and call the flag to control behavior.
**4. Control Remotely:** Toggle the flag in the Unleash UI to instantly change the feature's visibility in your live app. 

### Unleash Architecture

<pre>
  React App
   ↓
Unleash Client SDK
   ↓
Unleash Server (API)
   ↓
PostgreSQL Database

</pre>

### What is react and react based application ?
React (also known as React.js or ReactJS) is an open-source JavaScript library for building user interfaces (UIs) using a component-based approach. A React-based application is an application (web, mobile, or desktop) built using this library's principles and tools to create dynamic and interactive user experiences.

### Setup the react based application 

**1. Install npm & Create a Next.js**

**2. Run this command once to Prevent “Stuck on Loading” Issue**

      NODE_OPTIONS="--dns-result-order=ipv4first"
      
**3. Create a Next.js (React) App**

      npx --yes create-next-app@latest my-react-app

**4. Go to Project Folder**

      cd my-react-app
      npm run dev
      
**5. Open in Browser**

      http://localhost:3000

**6. Create docker-compose.yml**

        version: "3.8"

        services:
          postgres:
            image: postgres:15
            container_name: unleash-postgres
            environment:
              POSTGRES_DB: react
              POSTGRES_USER: react
              POSTGRES_PASSWORD: react123
            ports:
              - "5432:5432"
        
          unleash:
            image: react-custom:7.4
            container_name: unleash-server
            depends_on:
              - postgres
            ports:
              - "4242:4242"
            environment:
              DATABASE_URL: postgres://unleash:unleash@postgres:5432/unleash
              DATABASE_SSL: "false"
              INIT_FRONTEND_API_TOKENS: default:development.unleash-insecure-api-token

**7. Run the docker compose file, using -d the container will run in the background**

      sudo docker-compose up -d

### ✅ Integrate Unleash with React (Local App)

**1. Install Unleash React SDK**

      npm install @unleash/proxy-client-react

**2. Create a file: src/unleash.ts**

      import { createUnleashProxyClient } from '@unleash/proxy-client-react';

      export const unleashClient = createUnleashProxyClient({
        url: 'http://localhost:4242/api/frontend',
        clientKey: 'default:development.unleash-insecure-api-token',
        appName: 'react-app',
      });

**3. Wrap Your App with UnleashProvider,Update src/main.tsx or src/index.tsx**

      import React from 'react';
      import ReactDOM from 'react-dom/client';
      import App from './App';
      import { UnleashProvider } from '@unleash/proxy-client-react';
      import { unleashClient } from './unleash';
      
      ReactDOM.createRoot(document.getElementById('root')!).render(
        <React.StrictMode>
          <UnleashProvider unleashClient={unleashClient}>
            <App />
          </UnleashProvider>
        </React.StrictMode>
      );

  




