# Formula/bodo-rc.rb — erzeugt aus dem Kanal-Manifest, nicht von Hand ändern.
#
# Quelle: scripts/cli-kanaele.ts (Verb `rendern`). Fassung und jede Prüfsumme stammen aus
# https://cli.bodo-app.com/rc/manifest.json — eine Wahrheitsquelle für alle Kanäle.
class BodoRc < Formula
  desc "Kommandozeile der Bodo-Unternehmensplattform"
  homepage "https://cli.bodo-app.com"
  url "https://cli.bodo-app.com/v/2026.1023.4316-rc/bodo-darwin-arm64"
  version "2026.1023.4316-rc"
  sha256 "c9a737a236fd6e0fb8d38313ca937fd160afb623cd67e257e96af863d2f4f1a0"
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
      url "https://cli.bodo-app.com/v/2026.1023.4316-rc/bodo-linux-arm64"
      sha256 "873424394767b6685836a8e0375b2701bc2104bedc9278b6ff655e8392df38f8"
    end
    on_intel do
      url "https://cli.bodo-app.com/v/2026.1023.4316-rc/bodo-linux-x64"
      sha256 "40ba7028b407338e82a45b2c5a244d7ca68dedb9e434637c7106e832b5eaeba6"
    end
  end

  def install
    bin.install Dir["bodo-*"].first => "bodo"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/bodo version")
  end
end
