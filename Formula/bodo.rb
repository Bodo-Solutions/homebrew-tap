# Formula/bodo.rb — erzeugt aus dem Kanal-Manifest, nicht von Hand ändern.
#
# Quelle: scripts/cli-kanaele.ts (Verb `rendern`). Fassung und jede Prüfsumme stammen aus
# https://cli.bodo-app.com/stable/manifest.json — eine Wahrheitsquelle für alle Kanäle.
class Bodo < Formula
  desc "Kommandozeile der Bodo-Unternehmensplattform"
  homepage "https://cli.bodo-app.com"
  url "https://cli.bodo-app.com/v/2026.1022.4230/bodo-darwin-arm64"
  version "2026.1022.4230"
  sha256 "06f8e1cfd8482150cc33cd1757d8b3e0449f7ae5530ed438f3ac57fceea78f3c"
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
      url "https://cli.bodo-app.com/v/2026.1022.4230/bodo-linux-arm64"
      sha256 "d2a9f19fef92f4aff7e3ea31d1f7bbee4472ed30d3d67d79a8c9c3648fc484e9"
    end
    on_intel do
      url "https://cli.bodo-app.com/v/2026.1022.4230/bodo-linux-x64"
      sha256 "e93ab83cbc6daa4b52a88a16b0613ca747818e682a03befd4ec30f9361e13bce"
    end
  end

  def install
    bin.install Dir["bodo-*"].first => "bodo"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/bodo version")
  end
end
