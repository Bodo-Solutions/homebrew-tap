# Formula/bodo-rc.rb — erzeugt aus dem Kanal-Manifest, nicht von Hand ändern.
#
# Quelle: scripts/cli-kanaele.ts (Verb `rendern`). Fassung und jede Prüfsumme stammen aus
# https://cli.bodo-app.com/rc/manifest.json — eine Wahrheitsquelle für alle Kanäle.
class BodoRc < Formula
  desc "Kommandozeile der Bodo-Unternehmensplattform"
  homepage "https://cli.bodo-app.com"
  url "https://cli.bodo-app.com/v/2026.1028.4509-rc/bodo-darwin-arm64"
  version "2026.1028.4509-rc"
  sha256 "edbaf2e433461d5d8a806f6467528e830bff1eea8fc62fffcec0fbf3fa9a1d23"
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
      url "https://cli.bodo-app.com/v/2026.1028.4509-rc/bodo-linux-arm64"
      sha256 "57d50b61037c90187668169cd5ed7ee68076dc52b78c8189418ea0a2ce26fbb4"
    end
    on_intel do
      url "https://cli.bodo-app.com/v/2026.1028.4509-rc/bodo-linux-x64"
      sha256 "bf45bcde79ad22cc2cc8f3b74171cd94e5825ddecd92da7833ca40983159b9d6"
    end
  end

  def install
    bin.install Dir["bodo-*"].first => "bodo"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/bodo version")
  end
end
