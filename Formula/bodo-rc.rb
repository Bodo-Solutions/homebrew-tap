# Formula/bodo-rc.rb — erzeugt aus dem Kanal-Manifest, nicht von Hand ändern.
#
# Quelle: scripts/cli-kanaele.ts (Verb `rendern`). Fassung und jede Prüfsumme stammen aus
# https://cli.bodo-app.com/rc/manifest.json — eine Wahrheitsquelle für alle Kanäle.
class BodoRc < Formula
  desc "Kommandozeile der Bodo-Unternehmensplattform"
  homepage "https://cli.bodo-app.com"
  url "https://cli.bodo-app.com/v/2026.1022.4246-rc/bodo-darwin-arm64"
  version "2026.1022.4246-rc"
  sha256 "8e439a8e96f0d97f0d63f36893d28defd886c5cb2083a17ac923ab7f840d6785"
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
      url "https://cli.bodo-app.com/v/2026.1022.4246-rc/bodo-linux-arm64"
      sha256 "af2104ee473f57c4a0bf152934b939ce11c69a4f836e025ca8803ae4fd779d1d"
    end
    on_intel do
      url "https://cli.bodo-app.com/v/2026.1022.4246-rc/bodo-linux-x64"
      sha256 "f23e08dcbcd5ee0f06fae58f924e1a61b697000699df3247d264d31533caecac"
    end
  end

  def install
    bin.install Dir["bodo-*"].first => "bodo"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/bodo version")
  end
end
