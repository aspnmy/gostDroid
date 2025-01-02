# https://gioui.org/doc/install

NAME=gostctl
BINDIR=bin
Apk_Apk_Version=$(shell cat apk_Apk_Version/apk_Apk_Version.go | grep 'Apk_Apk_Version =' | sed 's/.*\"\(.*\)\".*/\1/g')
Gost_Apk_Version=$(shell cat gost_Apk_Version/gost_Apk_Version.go | grep 'Gost_Apk_Version =' | sed 's/.*\"\(.*\)\".*/\1/g')
GOBUILD=CGO_ENABLED=0 go build --ldflags="-s -w" -v -x -a
GOFILES=*.go

PLATFORM_LIST = \
	linux-amd64 \
	# linux-arm64

WINDOWS_ARCH_LIST = \
	windows-amd64 \
	windows-arm64

linux-amd64:
	GOOS=linux GOARCH=amd64 CGO_ENABLED=1 go build --ldflags="-s -w" -v -x -a -o $(BINDIR)/$(NAME)_$(Gost_Apk_Version)_$(Apk_Version)_$@ $(GOFILES)

linux-arm64:
	GOOS=linux GOARCH=arm64 CGO_ENABLED=1 go build --ldflags="-s -w" -v -x -a -o $(BINDIR)/$(NAME)_$(Gost_Apk_Version)_$(Apk_Version)_$@ $(GOFILES)
    
darwin-amd64:
	GOOS=darwin GOARCH=amd64 $(GOBUILD) -o $(BINDIR)/$(NAME)_$(Gost_Apk_Version)_$(Apk_Version)_$@ $(GOFILES)

darwin-arm64:
	GOOS=darwin GOARCH=arm64 $(GOBUILD) -o $(BINDIR)/$(NAME)_$(Gost_Apk_Version)_$(Apk_Version)_$@ $(GOFILES)

# https://github.com/tc-hib/go-winres
windows-amd64:
	GOOS=windows GOARCH=amd64 go-winres make --in winres/winres.json --out winres/rsrc
	GOOS=windows GOARCH=amd64 CGO_ENABLED=0 go build -ldflags="-s -w -H windowsgui" -o $(BINDIR)/$(NAME)_$(Gost_Apk_Version)_$(Apk_Version)_$@.exe $(GOFILES)

windows-arm64:
	GOOS=windows GOARCH=arm64 go-winres make --in winres/winres.json --out winres/rsrc
	GOOS=windows GOARCH=arm64 CGO_ENABLED=0 go build -ldflags="-s -w -H windowsgui" -o $(BINDIR)/$(NAME)_$(Gost_Apk_Version)_$(Apk_Version)_$@.exe $(GOFILES)

# go install gioui.org/cmd/gogio@latest
android:
	gogio -x -work -target android -minsdk 22 -targetsdk 33 -Apk_Version $(Apk_Version).1 -name GOST -signkey build/sign.keystore -signpass android -appid gost.run -o $(BINDIR)/$(NAME)_$(Gost_Apk_Version)_$(Apk_Version).aab .
	gogio -x -work -target android -minsdk 22 -targetsdk 33 -Apk_Version $(Apk_Version).1 -name GOST -signkey build/sign.keystore -signpass android -appid gost.run -o $(BINDIR)/$(NAME)_$(Gost_Apk_Version)_$(Apk_Version).apk .

gz_releases=$(addsuffix .gz, $(PLATFORM_LIST))
zip_releases=$(addsuffix .zip, $(WINDOWS_ARCH_LIST))

$(gz_releases): %.gz : %
	chmod +x $(BINDIR)/$(NAME)_$(Gost_Apk_Version)_$(Apk_Version)_$(basename $@)
	gzip -f -S .gz $(BINDIR)/$(NAME)_$(Gost_Apk_Version)_$(Apk_Version)_$(basename $@)

$(zip_releases): %.zip : %
	zip -m -j $(BINDIR)/$(NAME)_$(Gost_Apk_Version)_$(Apk_Version)_$(basename $@).zip $(BINDIR)/$(NAME)_$(Gost_Apk_Version)_$(Apk_Version)_$(basename $@).exe

releases: $(gz_releases) $(zip_releases) android

clean:
	rm *.syso -f
	rm $(BINDIR)/* -rf
