# Formula/bodo-rc.rb — erzeugt aus dem Kanal-Manifest, nicht von Hand ändern.
#
# Quelle: scripts/cli-kanaele.ts (Verb `rendern`). Fassung und jede Prüfsumme stammen aus
# https://cli.bodo-app.com/rc/manifest.json — eine Wahrheitsquelle für alle Kanäle.
class BodoRc < Formula
  desc "Kommandozeile der Bodo-Unternehmensplattform"
  homepage "https://cli.bodo-app.com"
  url "https://cli.bodo-app.com/v/2026.1024.4327-rc/bodo-darwin-arm64"
  version "2026.1024.4327-rc"
  sha256 "d21ef5a1a29c749b5b61ba52179774055f4adbb82a17678953cdd39ff1db34a7"
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
      url "https://cli.bodo-app.com/v/2026.1024.4327-rc/bodo-linux-arm64"
      sha256 "dea6eb541ceff75c38fc3b55553b2c8cb61b8016227a8a4f8c94431fd01f8b9a"
    end
    on_intel do
      url "https://cli.bodo-app.com/v/2026.1024.4327-rc/bodo-linux-x64"
      sha256 "e24c704bf966e3b22e6a7e2b07c980d980afb9d8f72caaf2ab244b797cf4ff7f"
    end
  end

  def install
    bin.install Dir["bodo-*"].first => "bodo"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/bodo version")
  end
end
