# Formula/bodo-rc.rb — erzeugt aus dem Kanal-Manifest, nicht von Hand ändern.
#
# Quelle: scripts/cli-kanaele.ts (Verb `rendern`). Fassung und jede Prüfsumme stammen aus
# https://cli.bodo-app.com/rc/manifest.json — eine Wahrheitsquelle für alle Kanäle.
class BodoRc < Formula
  desc "Kommandozeile der Bodo-Unternehmensplattform"
  homepage "https://cli.bodo-app.com"
  url "https://cli.bodo-app.com/v/2026.1009.3804-rc/bodo-darwin-arm64"
  version "2026.1009.3804-rc"
  sha256 "8f3b5f729c50b9b36822f05b306f81e929a7dd3f3f2b762f3166d3bd5ce4a869"
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
      url "https://cli.bodo-app.com/v/2026.1009.3804-rc/bodo-linux-arm64"
      sha256 "7cec796f1513cd33c66555caab8919fb7656cbe9a5a97d2667788fe5bd127b7e"
    end
    on_intel do
      url "https://cli.bodo-app.com/v/2026.1009.3804-rc/bodo-linux-x64"
      sha256 "2f44d16bdd8ce9b79f76d8e1d6eac9547273b2d9540d2bae1185cdd3e9f2ba77"
    end
  end

  def install
    bin.install Dir["bodo-*"].first => "bodo"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/bodo version")
  end
end
