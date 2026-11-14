# Formula/bodo.rb — erzeugt aus dem Kanal-Manifest, nicht von Hand ändern.
#
# Quelle: scripts/cli-channels.ts (Verb `rendern`). Fassung und jede Prüfsumme stammen aus
# https://cli.bodo-app.com/stable/manifest.json — eine Wahrheitsquelle für alle Kanäle.
class Bodo < Formula
  desc "Kommandozeile der Bodo-Unternehmensplattform"
  homepage "https://cli.bodo-app.com"
  url "https://cli.bodo-app.com/v/2026.1114.4730/bodo-darwin-arm64"
  version "2026.1114.4730"
  sha256 "550b3493cdbb2af5ad10efa32b16ff13c1ec437444aca8a1d3bdc17bc9f2c70f"
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
      url "https://cli.bodo-app.com/v/2026.1114.4730/bodo-linux-arm64"
      sha256 "8bd60ace2650fc79e8ae5fb1b38ed6384575392a3f9f852bf77f62a2a6f54d86"
    end
    on_intel do
      url "https://cli.bodo-app.com/v/2026.1114.4730/bodo-linux-x64"
      sha256 "b2ac46fde9b72ea84830cf2a696443d719047b6d7413889445bce6c6c3af0fb2"
    end
  end

  def install
    bin.install Dir["bodo-*"].first => "bodo"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/bodo version")
  end
end
