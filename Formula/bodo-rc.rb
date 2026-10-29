# Formula/bodo-rc.rb — erzeugt aus dem Kanal-Manifest, nicht von Hand ändern.
#
# Quelle: scripts/cli-kanaele.ts (Verb `rendern`). Fassung und jede Prüfsumme stammen aus
# https://cli.bodo-app.com/rc/manifest.json — eine Wahrheitsquelle für alle Kanäle.
class BodoRc < Formula
  desc "Kommandozeile der Bodo-Unternehmensplattform"
  homepage "https://cli.bodo-app.com"
  url "https://cli.bodo-app.com/v/2026.1029.4589-rc/bodo-darwin-arm64"
  version "2026.1029.4589-rc"
  sha256 "d71075f3a8004e7c4878244ecf06b0d1f720e9401e9d5a608e605eccf75ae90a"
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
      url "https://cli.bodo-app.com/v/2026.1029.4589-rc/bodo-linux-arm64"
      sha256 "834d6306e6acca1798a9ac66ab0b219f7054d1d5a194156a17dd558e312c5c31"
    end
    on_intel do
      url "https://cli.bodo-app.com/v/2026.1029.4589-rc/bodo-linux-x64"
      sha256 "1a07ab9710416ef37e2f6c31c58da741aed0df911d103be59480fe726799bbf4"
    end
  end

  def install
    bin.install Dir["bodo-*"].first => "bodo"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/bodo version")
  end
end
