.PHONY: run install build dmg clean release

VENV ?= $(HOME)/.hermes/hermes-agent/venv
PYTHON := $(VENV)/bin/python3
APP_NAME := SmartClipAI
DMG_NAME := SmartClipAI.dmg

run:
	$(PYTHON) src/smartclipai.py

install:
	$(PYTHON) -m pip install -r requirements.txt

build: clean
	@echo "=== Building $(APP_NAME).app ==="
	@mkdir -p dist/$(APP_NAME).app/Contents/MacOS dist/$(APP_NAME).app/Contents/Resources
	@cp src/smartclipai.py dist/$(APP_NAME).app/Contents/Resources/main_script.py
	@cp assets/icon.icns dist/$(APP_NAME).app/Contents/Resources/applet.icns 2>/dev/null || true
	@cp assets/banner.png dist/$(APP_NAME).app/Contents/Resources/ 2>/dev/null || true
	@# Info.plist
	@/bin/cat > dist/$(APP_NAME).app/Contents/Info.plist << 'PLIST'
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <key>CFBundleExecutable</key>
    <string>$(APP_NAME)</string>
    <key>CFBundleIdentifier</key>
    <string>com.timwynter.$(APP_NAME)</string>
    <key>CFBundleName</key>
    <string>$(APP_NAME)</string>
    <key>CFBundleDisplayName</key>
    <string>$(APP_NAME)</string>
    <key>CFBundleVersion</key>
    <string>1.0.0</string>
    <key>CFBundleShortVersionString</key>
    <string>1.0.0</string>
    <key>CFBundlePackageType</key>
    <string>APPL</string>
    <key>LSUIElement</key>
    <true/>
    <key>NSHighResolutionCapable</key>
    <true/>
</dict>
</plist>
PLIST
	@# Compile C launcher
	@xcrun clang -O2 -o dist/$(APP_NAME).app/Contents/MacOS/$(APP_NAME) \
		-I. scripts/c_launcher.c 2>/dev/null || \
	 (echo '#include <unistd.h>' > /tmp/launcher.c; \
	  echo '#include <stdlib.h>' >> /tmp/launcher.c; \
	  echo '#include <string.h>' >> /tmp/launcher.c; \
	  echo 'int main(int argc, char *argv[]) {' >> /tmp/launcher.c; \
	  echo '  char buf[4096];' >> /tmp/launcher.c; \
	  echo '  const char *paths[] = {"/opt/homebrew/bin/python3.11","/opt/homebrew/bin/python3","/usr/bin/python3",NULL};' >> /tmp/launcher.c; \
	  echo '  char *p = strstr(argv[0],"/MacOS/"); if(p){size_t l=p-argv[0]; memcpy(buf,argv[0],l); strcpy(buf+l,"/Resources"); chdir(buf);}' >> /tmp/launcher.c; \
	  echo '  for(int i=0;paths[i];i++) execl(paths[i],paths[i],"main_script.py",(char*)NULL);' >> /tmp/launcher.c; \
	  echo '  execl("/usr/bin/python3","python3","main_script.py",(char*)NULL); return 1;}' >> /tmp/launcher.c; \
	  xcrun clang -O2 -o dist/$(APP_NAME).app/Contents/MacOS/$(APP_NAME) /tmp/launcher.c)
	@# Sign
	@codesign --force --deep --sign - dist/$(APP_NAME).app 2>/dev/null || true
	@echo "✓ $(APP_NAME).app built"

dmg: build
	@echo "=== Building $(DMG_NAME) ==="
	@mkdir -p /tmp/dmg-src
	@cp -R dist/$(APP_NAME).app /tmp/dmg-src/
	@ln -sf /Applications /tmp/dmg-src/Applications
	@hdiutil create -volname "$(APP_NAME)" -srcfolder /tmp/dmg-src \
		-ov -format UDZO -fs HFS+ "dist/$(DMG_NAME)" 2>/dev/null || \
	 diskutil image create from /tmp/dmg-src --format UDZO \
		--volumeName "$(APP_NAME)" --out "dist/$(DMG_NAME)" 2>/dev/null
	@rm -rf /tmp/dmg-src
	@echo "✓ dist/$(DMG_NAME) created"
	@ls -lh dist/$(DMG_NAME)

release: dmg
	@echo "=== Creating GitHub Release ==="
	gh release create v1.0.0 "dist/$(DMG_NAME)#$(DMG_NAME)" \
		"dist/$(APP_NAME).app#$(APP_NAME).app" \
		--title "SmartClipAI v1.0.0" \
		--notes "First release of SmartClipAI — AI-powered clipboard assistant for macOS" \
		--target main 2>/dev/null || \
	 echo "Release exists or gh not configured. DMG is at dist/$(DMG_NAME)"

clean:
	rm -rf dist/ build/