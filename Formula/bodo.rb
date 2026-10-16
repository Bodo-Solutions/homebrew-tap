# Formula/bodo.rb — erzeugt aus dem Kanal-Manifest, nicht von Hand ändern.
#
# Quelle: scripts/cli-kanaele.ts (Verb `rendern`). Fassung und jede Prüfsumme stammen aus
# https://cli.bodo-app.com/stable/manifest.json — eine Wahrheitsquelle für alle Kanäle.
class Bodo < Formula
  desc "Kommandozeile der Bodo-Unternehmensplattform"
  homepage "https://cli.bodo-app.com"
  url "https://cli.bodo-app.com/v/2026.1016.3983/bodo-darwin-arm64"
  version "2026.1016.3983"
  sha256 "c930096cf941f48262fc41a735d11641a8b8e3e78166b113a2265bd07f432102"
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
      url "https://cli.bodo-app.com/v/2026.1016.3983/bodo-linux-arm64"
      sha256 "d2210ce6d90a4d0774b0010d07c9a690b537bc9e5d45499b1e43fec2af6686a8"
    end
    on_intel do
      url "https://cli.bodo-app.com/v/2026.1016.3983/bodo-linux-x64"
      sha256 "b3f0032a06c1b5ad66abfc9fee2b0086bac6a856d03d600d1909eec3a2cb05ac"
    end
  end

  def install
    bin.install Dir["bodo-*"].first => "bodo"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/bodo version")
  end
end
