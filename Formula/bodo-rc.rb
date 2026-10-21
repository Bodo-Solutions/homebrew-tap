# Formula/bodo-rc.rb — erzeugt aus dem Kanal-Manifest, nicht von Hand ändern.
#
# Quelle: scripts/cli-kanaele.ts (Verb `rendern`). Fassung und jede Prüfsumme stammen aus
# https://cli.bodo-app.com/rc/manifest.json — eine Wahrheitsquelle für alle Kanäle.
class BodoRc < Formula
  desc "Kommandozeile der Bodo-Unternehmensplattform"
  homepage "https://cli.bodo-app.com"
  url "https://cli.bodo-app.com/v/2026.1021.4161-rc/bodo-darwin-arm64"
  version "2026.1021.4161-rc"
  sha256 "8a995fdaddb6784bbbfaaef1718f598778298b0ed0e01cc566ca3a846537be40"
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
      url "https://cli.bodo-app.com/v/2026.1021.4161-rc/bodo-linux-arm64"
      sha256 "0a6584d9fced544bb976e6b66a237e201feec975b6cd21bb5e23fd2ccbbf71d9"
    end
    on_intel do
      url "https://cli.bodo-app.com/v/2026.1021.4161-rc/bodo-linux-x64"
      sha256 "c52bf23842bb1ee1b9ba0d45b12f8a31520e6bfebbe3111a26fca5779f0e977a"
    end
  end

  def install
    bin.install Dir["bodo-*"].first => "bodo"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/bodo version")
  end
end
