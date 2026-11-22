# Formula/bodo.rb — erzeugt aus dem Kanal-Manifest, nicht von Hand ändern.
#
# Quelle: scripts/cli-channels.ts (Verb `rendern`). Fassung und jede Prüfsumme stammen aus
# https://cli.bodo-app.com/stable/manifest.json — eine Wahrheitsquelle für alle Kanäle.
class Bodo < Formula
  desc "Kommandozeile der Bodo-Unternehmensplattform"
  homepage "https://cli.bodo-app.com"
  url "https://cli.bodo-app.com/v/2026.1122.4764/bodo-darwin-arm64"
  version "2026.1122.4764"
  sha256 "561a72f4bc4eb39043e58b809fc3e166de66267521e742b37e17f01e4b2d7617"
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
      url "https://cli.bodo-app.com/v/2026.1122.4764/bodo-linux-arm64"
      sha256 "7d707335bdcb01e62043130c62150b88c718372bd129a143e0100ef861b7bff4"
    end
    on_intel do
      url "https://cli.bodo-app.com/v/2026.1122.4764/bodo-linux-x64"
      sha256 "f85fd9b38c5590a57913e85d641f3785fba933ca0aeec91749eb64d15f670ffc"
    end
  end

  def install
    bin.install Dir["bodo-*"].first => "bodo"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/bodo version")
  end
end
