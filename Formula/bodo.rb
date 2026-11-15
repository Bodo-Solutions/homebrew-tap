# Formula/bodo.rb — erzeugt aus dem Kanal-Manifest, nicht von Hand ändern.
#
# Quelle: scripts/cli-channels.ts (Verb `rendern`). Fassung und jede Prüfsumme stammen aus
# https://cli.bodo-app.com/stable/manifest.json — eine Wahrheitsquelle für alle Kanäle.
class Bodo < Formula
  desc "Kommandozeile der Bodo-Unternehmensplattform"
  homepage "https://cli.bodo-app.com"
  url "https://cli.bodo-app.com/v/2026.1115.4738/bodo-darwin-arm64"
  version "2026.1115.4738"
  sha256 "9d5b80cc80263696f9d924b0ec1505822dc023a61da8f36ba5779a51125bab1e"
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
      url "https://cli.bodo-app.com/v/2026.1115.4738/bodo-linux-arm64"
      sha256 "6b57f9db7f83db490f1d4e06c6aa0e6e66f2949f78fb2f1e48e7fc63466dd49a"
    end
    on_intel do
      url "https://cli.bodo-app.com/v/2026.1115.4738/bodo-linux-x64"
      sha256 "76644e43eec2882ddaeb70c5880fa3a1de92720e56a2136a917efae52b5a593a"
    end
  end

  def install
    bin.install Dir["bodo-*"].first => "bodo"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/bodo version")
  end
end
