# Formula/bodo.rb — erzeugt aus dem Kanal-Manifest, nicht von Hand ändern.
#
# Quelle: scripts/cli-channels.ts (Verb `rendern`). Fassung und jede Prüfsumme stammen aus
# https://cli.bodo-app.com/stable/manifest.json — eine Wahrheitsquelle für alle Kanäle.
class Bodo < Formula
  desc "Kommandozeile der Bodo-Unternehmensplattform"
  homepage "https://cli.bodo-app.com"
  url "https://cli.bodo-app.com/v/2026.1127.4769/bodo-darwin-arm64"
  version "2026.1127.4769"
  sha256 "d132553bee30e3744c30c0af03ca4e544124bbc4526b0b3bb1b9f260d9096fe3"
  license :cannot_represent

  livecheck do
    url "https://cli.bodo-app.com/stable/manifest.json"
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
      url "https://cli.bodo-app.com/v/2026.1127.4769/bodo-linux-arm64"
      sha256 "3a030b341f1b22fa23a0ab2fcda1dd3a63e12a1be1096cc668502eac5903387e"
    end
    on_intel do
      url "https://cli.bodo-app.com/v/2026.1127.4769/bodo-linux-x64"
      sha256 "44433c40b15f448cbb2f0e8f9a020f0082bc703bac1a81e1aa7ec2a0a8636f86"
    end
  end

  def install
    bin.install Dir["bodo-*"].first => "bodo"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/bodo version")
  end
end
