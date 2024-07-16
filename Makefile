build:
	bun build --compile --target=bun-linux-x64-modern ./websocket-server.js --outfile ./build/linux-x64/devreloader
	bun build --compile --target=bun-windows-x64-modern ./websocket-server.js --outfile ./build/windows-x64/devreloader
	bun build --compile --target=bun-darwin-x64 ./websocket-server.js --outfile ./build/mac-x64/devreloader
	bun build --compile --target=bun-darwin-arm64 ./websocket-server.js --outfile ./build/mac-arm64/devreloader
