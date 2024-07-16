# Dev Browser Reloader

Reload browser on file changes. A simple Bun websocket server that listens and sends a reload message to JS client which will trigger a `location.reload()`. Super usefull if you want to see changes made in .tsx, .jsx, html, css etc files in your 


## Usage

The websocket server is built in Bunjs (super basic). 
You can clone repo and build binary with:

- `bun build ./websocket-server.js --compile --outfile ./build/devreloader` (on your OS);
- [more bun compile to executable commands](https://bun.sh/docs/bundler/executables);


But, you can also use the binary already built (checkout **Releases**). If on linux/mac do a: `sudo chmod +x devreloader` to make the binary executable. 

Nice, you got the websocket server figured out and running now create a file named **reload-browser.js** in your assets or public folder and add it to your main page entrypoint (index.html, base.html, index.tsx etc.) like this:

```js
// This is a React/Hono component
import type { FC } from 'hono/jsx'
import { NavBar } from './NavBar'


export const Layout: FC = (props) => {
    return (
        <html>
            <head>
                <meta charset="UTF-8" />
                <meta name="viewport" content="width=device-width, initial-scale=1.0" />
                <link rel="stylesheet" href="/static/output.css" />
                <title>PFASimplu</title>
            </head>
            <body class="container mx-auto">

                <NavBar />

                <main class="px-4">
                    {props.children}
                </main>
                
                <script src="/static/reload-browser.js"></script>

                // OR for a index.html file

                <script>

                const socket = new WebSocket("ws://localhost:15173");

                socket.addEventListener("open", (event) => {
                    console.log("WebSocket connection opened");
                });

                socket.addEventListener("message", (event) => {
                    console.log("Message from server:", event.data);
                    if (event.data === 'reload') {
                        location.reload();
                    }
                });

                socket.addEventListener("close", (event) => {
                    console.log("WebSocket connection closed");
                });

                socket.addEventListener("error", (event) => {
                    console.error("WebSocket error:", event);
                });

                </script>

            </body>
        </html>
    )
}

```

Copy the contents of `reload-browser.js` file from this repo where you created the reload-browser.js file. That code will listen for new messages from the server and reload the web page when it receives a 'reload' message.


That's it!


## Configs

By default server runs on host "0.0.0.0" and on port 15173. In case you get any issues with the port or you want to change it just add the envs variables before running either the script or binary.

- `PORT=4689 HOST="127.0.0.1" bun websocket-server.js` - if you are just running the script;
- `PORT=4689 HOST="127.0.0.1" ./devreloader` - if you are running the binary;
