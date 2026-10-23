# Formula/bodo-rc.rb — erzeugt aus dem Kanal-Manifest, nicht von Hand ändern.
#
# Quelle: scripts/cli-kanaele.ts (Verb `rendern`). Fassung und jede Prüfsumme stammen aus
# https://cli.bodo-app.com/rc/manifest.json — eine Wahrheitsquelle für alle Kanäle.
class BodoRc < Formula
  desc "Kommandozeile der Bodo-Unternehmensplattform"
  homepage "https://cli.bodo-app.com"
  url "https://cli.bodo-app.com/v/2026.1023.4306-rc/bodo-darwin-arm64"
  version "2026.1023.4306-rc"
  sha256 "4dc550962ee7f691d940c4e7c609d692cb3a5dde89a792334e3660b1fcae5367"
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
      url "https://cli.bodo-app.com/v/2026.1023.4306-rc/bodo-linux-arm64"
      sha256 "e6297e07bcedb729d6eb910e3db6737655b419bd3fabb01f477a35c4fccc156b"
    end
    on_intel do
      url "https://cli.bodo-app.com/v/2026.1023.4306-rc/bodo-linux-x64"
      sha256 "7940de0424eaff1ed27eb0e7573443522586c611497b267f63b7674651d1ba88"
    end
  end

  def install
    bin.install Dir["bodo-*"].first => "bodo"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/bodo version")
  end
end
