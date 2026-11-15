# Formula/bodo.rb — erzeugt aus dem Kanal-Manifest, nicht von Hand ändern.
#
# Quelle: scripts/cli-channels.ts (Verb `rendern`). Fassung und jede Prüfsumme stammen aus
# https://cli.bodo-app.com/stable/manifest.json — eine Wahrheitsquelle für alle Kanäle.
class Bodo < Formula
  desc "Kommandozeile der Bodo-Unternehmensplattform"
  homepage "https://cli.bodo-app.com"
  url "https://cli.bodo-app.com/v/2026.1115.4739/bodo-darwin-arm64"
  version "2026.1115.4739"
  sha256 "06d09906d5e8dc23f4a2e9770a39b33a9cc5396d2b4e7756a3dd6b4a6ae4eb87"
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
      url "https://cli.bodo-app.com/v/2026.1115.4739/bodo-linux-arm64"
      sha256 "baa3f122688a2682d34fc4f48e831559c9aeedbc2b213e835b6617545972d182"
    end
    on_intel do
      url "https://cli.bodo-app.com/v/2026.1115.4739/bodo-linux-x64"
      sha256 "2d77a2519fcc7d3b97ab96c7ce220728dadb31d77baa456617efa0b06c2a4aa0"
    end
  end

  def install
    bin.install Dir["bodo-*"].first => "bodo"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/bodo version")
  end
end
