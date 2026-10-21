# Formula/bodo-rc.rb — erzeugt aus dem Kanal-Manifest, nicht von Hand ändern.
#
# Quelle: scripts/cli-kanaele.ts (Verb `rendern`). Fassung und jede Prüfsumme stammen aus
# https://cli.bodo-app.com/rc/manifest.json — eine Wahrheitsquelle für alle Kanäle.
class BodoRc < Formula
  desc "Kommandozeile der Bodo-Unternehmensplattform"
  homepage "https://cli.bodo-app.com"
  url "https://cli.bodo-app.com/v/2026.1021.4190-rc/bodo-darwin-arm64"
  version "2026.1021.4190-rc"
  sha256 "f380441dbac152228c03e673ccea93f5f41042bda5292f64e8aef4bf9a163d95"
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
      url "https://cli.bodo-app.com/v/2026.1021.4190-rc/bodo-linux-arm64"
      sha256 "57cf1f5d45bb47a0a90ae97403cf979f6745cadf1cc0361bed87ece4607ac65c"
    end
    on_intel do
      url "https://cli.bodo-app.com/v/2026.1021.4190-rc/bodo-linux-x64"
      sha256 "67b43d1750ce6046bc9cc4e504dbf69097dfb173619256b09b67742862e58dea"
    end
  end

  def install
    bin.install Dir["bodo-*"].first => "bodo"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/bodo version")
  end
end
