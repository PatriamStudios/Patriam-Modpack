default:
	@echo "No Default make command configured"
	@echo "Please use either"
	@echo "   - make curseforge"
	@echo "   - make multimc"
	@echo "   - make technic"
	@echo "   - make all"
	@echo ""
	@echo "Curseforge will make a curseforge compatible zip"
	@echo "Multimc will make a multimc zip file which contains"
	@echo "   the packwiz updater"
	@echo ""
	@echo "Technic will make a technic pack zip"
	@echo ""
	@echo "All will make all packs it can"
	@echo ""
	
curseforge:
	@echo "Making Curseforge pack"
	packwiz curseforge export --pack-file .minecraft/pack.toml -o ../patriam-curseforge.zip
	7z d ../patriam-curseforge.zip overrides/packwiz-installer-bootstrap.jar overrides/pack.toml  overrides/index.toml	

modrinth:
	@echo "Making Modrinth pack"
	packwiz modrinth export --pack-file .minecraft/pack.toml -o ../patriam-modrinth.zip
	7z d ../patriam-modrinth.zip overrides/packwiz-installer-bootstrap.jar overrides/pack.toml  overrides/index.toml	

multimc:
	@echo "Making MultiMC pack"
	7z d ../patriam-multimc.zip ./* -r
	7z d ../patriam-multimc.zip ./.minecraft -r
	7z a ../patriam-multimc.zip ./* -r
	7z a ../patriam-multimc.zip ./.minecraft -r
	7z d ../patriam-multimc.zip ./.minecraft/mods ./.minecraft/pack.toml ./.minecraft/index.toml -r

technic:
	@echo "Making Technic pack"
	-rm -rf .technic
	-cp -r .minecraft .technic
	mv .technic/modpack.icon.png .technic/icon.png
	cd .technic && java -jar packwiz-installer-bootstrap.jar https://raw.githubusercontent.com/Merith-TK/patriam-modpack/main/.minecraft/pack.toml && cd ..
	-rm -rf .technic/packwiz*
	7z d ../patriam-technic.zip ./* -r
	7z a ../patriam-technic.zip ./.technic/* -r

clean:
	-rm -rf .technic
	-git gc --aggressive --prune

all: curseforge modrinth multimc technic clean

update-packwiz:
	go install github.com/packwiz/packwiz@latest
	clear
	@echo "Packwiz has been Updated"