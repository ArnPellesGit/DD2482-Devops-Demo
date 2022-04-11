## DD2482 - Demo - Week 4
This is a repo hosting the demo we ([Per Arn](https://github.com/ArnPellesGit), [John Landeholt](https://github.com/landeholt)) created for the DevOps course for Week 4 / Task 2. The title of our demo being "A portable devkit for CI/CD pipelines".

The slides we used for the demo can be found [here](https://www.figma.com/proto/sNInuXaUGIMTtQQVpyt3Ei/code-coverage?page-id=2%3A2&node-id=150%3A757&viewport=250%2C48%2C0.09&scaling=contain&starting-point-node-id=150%3A757&show-proto-sidebar=1).

## Getting Started with Dagger

This project was bootstrapped with Vite.

### Available Scripts

In the project directory, you can run:

### `yarn dev`

Runs the app in the development mode.\
Open [http://localhost:3000](http://localhost:3000) to view it in your browser.

The page will reload when you make changes.\
You may also see any lint errors in the console.

### `yarn test`

Launches the test runner in the interactive watch mode.\
See the section about [running tests](https://facebook.github.io/create-react-app/docs/running-tests) for more information.

### `yarn build`

Builds the app for production to the `build` folder.\
It correctly bundles React in production mode and optimizes the build for the best performance.


### Deployment

The demo is about how we can write a plan that can be executed systematically.

The `Netlify` plan is built by **Dagger**, but the `Surge` plan is built locally by @landeholt

#### Surge

https://github.com/ArnPellesGit/DD2482-Devops-Demo/blob/c71092cad35fa09ede75f747249f483b240f509f/main.cue#L98-L102

#### Netlify

```cue
deploy: netlify.#Deploy & {
			contents: build.contents.output
			site:     client.env.APP_NAME
			token:    client.env.NETLIFY_TOKEN
			team:     client.env.NETLIFY_TEAM
		}
```
