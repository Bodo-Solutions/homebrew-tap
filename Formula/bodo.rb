# Formula/bodo.rb — erzeugt aus dem Kanal-Manifest, nicht von Hand ändern.
#
# Quelle: scripts/cli-channels.ts (Verb `rendern`). Fassung und jede Prüfsumme stammen aus
# https://cli.bodo-app.com/stable/manifest.json — eine Wahrheitsquelle für alle Kanäle.
class Bodo < Formula
  desc "Kommandozeile der Bodo-Unternehmensplattform"
  homepage "https://cli.bodo-app.com"
  url "https://cli.bodo-app.com/v/2026.1128.4770/bodo-darwin-arm64"
  version "2026.1128.4770"
  sha256 "0a87e1f3fbf87eae4cf5b054e809d487af830944ac2d1323cd95f98be8594eeb"
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
      url "https://cli.bodo-app.com/v/2026.1128.4770/bodo-linux-arm64"
      sha256 "164550c670eb8d9915732c28a6efd01b96c3b64edb8d3b83f6aec97a3e4ef9ae"
    end
    on_intel do
      url "https://cli.bodo-app.com/v/2026.1128.4770/bodo-linux-x64"
      sha256 "13b2cc64adaf4a5bb4707b4b286962efbddb8be93a7022f939ee69411b02bed5"
    end
  end

  def install
    bin.install Dir["bodo-*"].first => "bodo"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/bodo version")
  end
end
