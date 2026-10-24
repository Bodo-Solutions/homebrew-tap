# Formula/bodo-rc.rb — erzeugt aus dem Kanal-Manifest, nicht von Hand ändern.
#
# Quelle: scripts/cli-kanaele.ts (Verb `rendern`). Fassung und jede Prüfsumme stammen aus
# https://cli.bodo-app.com/rc/manifest.json — eine Wahrheitsquelle für alle Kanäle.
class BodoRc < Formula
  desc "Kommandozeile der Bodo-Unternehmensplattform"
  homepage "https://cli.bodo-app.com"
  url "https://cli.bodo-app.com/v/2026.1024.4322-rc/bodo-darwin-arm64"
  version "2026.1024.4322-rc"
  sha256 "dd2076c6967bdd1edaae80879877627900ea8b2fedd8421c02339e7001b61db6"
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
      url "https://cli.bodo-app.com/v/2026.1024.4322-rc/bodo-linux-arm64"
      sha256 "64701e3b164c623ee48758c3df655d79dba2cc923067fba3460e4275ce2e63eb"
    end
    on_intel do
      url "https://cli.bodo-app.com/v/2026.1024.4322-rc/bodo-linux-x64"
      sha256 "6f9561304a65a40e689fb1a53a973e630fc035be0d263c69e9ba62a374819be1"
    end
  end

  def install
    bin.install Dir["bodo-*"].first => "bodo"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/bodo version")
  end
end
