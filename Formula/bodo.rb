# Formula/bodo.rb — erzeugt aus dem Kanal-Manifest, nicht von Hand ändern.
#
# Quelle: scripts/cli-channels.ts (Verb `rendern`). Fassung und jede Prüfsumme stammen aus
# https://cli.bodo-app.com/stable/manifest.json — eine Wahrheitsquelle für alle Kanäle.
class Bodo < Formula
  desc "Kommandozeile der Bodo-Unternehmensplattform"
  homepage "https://cli.bodo-app.com"
  url "https://cli.bodo-app.com/v/2026.1118.4749/bodo-darwin-arm64"
  version "2026.1118.4749"
  sha256 "86f610db79c3d6d7a43b142419d139b07c8240488cfd3fd53758ee2f8759f9af"
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
      url "https://cli.bodo-app.com/v/2026.1118.4749/bodo-linux-arm64"
      sha256 "55e23ea1b529990ecd790114c3f120df460d27a54dbdb2169b1f0012a2c0a944"
    end
    on_intel do
      url "https://cli.bodo-app.com/v/2026.1118.4749/bodo-linux-x64"
      sha256 "54c041ca6e98a53e4eb13f80ae327167240b0f1b07c9c987442db3d9918696cd"
    end
  end

  def install
    bin.install Dir["bodo-*"].first => "bodo"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/bodo version")
  end
end
