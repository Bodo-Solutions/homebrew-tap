# Formula/bodo-rc.rb — erzeugt aus dem Kanal-Manifest, nicht von Hand ändern.
#
# Quelle: scripts/cli-kanaele.ts (Verb `rendern`). Fassung und jede Prüfsumme stammen aus
# https://cli.bodo-app.com/rc/manifest.json — eine Wahrheitsquelle für alle Kanäle.
class BodoRc < Formula
  desc "Kommandozeile der Bodo-Unternehmensplattform"
  homepage "https://cli.bodo-app.com"
  url "https://cli.bodo-app.com/v/2026.1010.3843-rc/bodo-darwin-arm64"
  version "2026.1010.3843-rc"
  sha256 "33c376e040e1f50ca033d6c8d40f0d7235a36baa114f2105d722ae3c38f3c881"
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
      url "https://cli.bodo-app.com/v/2026.1010.3843-rc/bodo-linux-arm64"
      sha256 "6d61ee9962ddff7a1d77db960e55e8b5801824c2a3c670771bcc3cafea9e172c"
    end
    on_intel do
      url "https://cli.bodo-app.com/v/2026.1010.3843-rc/bodo-linux-x64"
      sha256 "5320e8b20dd9ba0c0125884e9094e3715bd03e610d0256cc2084c3a657d16f71"
    end
  end

  def install
    bin.install Dir["bodo-*"].first => "bodo"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/bodo version")
  end
end
