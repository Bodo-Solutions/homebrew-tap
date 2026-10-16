# Formula/bodo-rc.rb — erzeugt aus dem Kanal-Manifest, nicht von Hand ändern.
#
# Quelle: scripts/cli-kanaele.ts (Verb `rendern`). Fassung und jede Prüfsumme stammen aus
# https://cli.bodo-app.com/rc/manifest.json — eine Wahrheitsquelle für alle Kanäle.
class BodoRc < Formula
  desc "Kommandozeile der Bodo-Unternehmensplattform"
  homepage "https://cli.bodo-app.com"
  url "https://cli.bodo-app.com/v/2026.1016.3998-rc/bodo-darwin-arm64"
  version "2026.1016.3998-rc"
  sha256 "2c26516d4efe2e5571ce84d5a5de15ed442a83f5fc4cf9a4bc38b706ba95ae14"
  license :cannot_represent

  livecheck do
    url "https://cli.bodo-app.com/rc/manifest.json"
    regex(/^v?(\d+(?:\.\d+)+(?:-rc)?)$/i)
    strategy :json do |json, regex|
      json["version"]&.[](regex, 1)
    end
  end

  on_macos do
    depends_on arch: :arm64 unless Hardware::CPU.in_rosetta2?
  end

  on_linux do
    on_arm do
      url "https://cli.bodo-app.com/v/2026.1016.3998-rc/bodo-linux-arm64"
      sha256 "79c1eff61e27e1833607197cf30338d8dfc5ee6bd0bc1b927e1d28e909f4f669"
    end
    on_intel do
      url "https://cli.bodo-app.com/v/2026.1016.3998-rc/bodo-linux-x64"
      sha256 "5000110c8a24fede8c6eaadc206dfe495206ab281a6aad54c96bb50be9e158d2"
    end
  end

  def install
    bin.install Dir["bodo-*"].first => "bodo"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/bodo version")
  end
end
