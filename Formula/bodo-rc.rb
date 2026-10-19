# Formula/bodo-rc.rb — erzeugt aus dem Kanal-Manifest, nicht von Hand ändern.
#
# Quelle: scripts/cli-kanaele.ts (Verb `rendern`). Fassung und jede Prüfsumme stammen aus
# https://cli.bodo-app.com/rc/manifest.json — eine Wahrheitsquelle für alle Kanäle.
class BodoRc < Formula
  desc "Kommandozeile der Bodo-Unternehmensplattform"
  homepage "https://cli.bodo-app.com"
  url "https://cli.bodo-app.com/v/2026.1019.4078-rc/bodo-darwin-arm64"
  version "2026.1019.4078-rc"
  sha256 "1f0ca18047aaaa326f3150f19fef67239c16ce01223729994bd4bd81774fa1af"
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
      url "https://cli.bodo-app.com/v/2026.1019.4078-rc/bodo-linux-arm64"
      sha256 "73d355e2352d085ab3827fa576349f5e2657e0aef551cb9175d457ea45479853"
    end
    on_intel do
      url "https://cli.bodo-app.com/v/2026.1019.4078-rc/bodo-linux-x64"
      sha256 "062db375ee225be44dbdf4baef7f5e7831e807b79647d3267e9fcd4525c4c9c4"
    end
  end

  def install
    bin.install Dir["bodo-*"].first => "bodo"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/bodo version")
  end
end
