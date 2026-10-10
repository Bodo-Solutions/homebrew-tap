# Formula/bodo-rc.rb — erzeugt aus dem Kanal-Manifest, nicht von Hand ändern.
#
# Quelle: scripts/cli-kanaele.ts (Verb `rendern`). Fassung und jede Prüfsumme stammen aus
# https://cli.bodo-app.com/rc/manifest.json — eine Wahrheitsquelle für alle Kanäle.
class BodoRc < Formula
  desc "Kommandozeile der Bodo-Unternehmensplattform"
  homepage "https://cli.bodo-app.com"
  url "https://cli.bodo-app.com/v/2026.1010.3815-rc/bodo-darwin-arm64"
  version "2026.1010.3815-rc"
  sha256 "550ccb604c1e997638818f992d68822819207f17a7ad4894a58b7b9986566a22"
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
      url "https://cli.bodo-app.com/v/2026.1010.3815-rc/bodo-linux-arm64"
      sha256 "b086113e667248e01bd40b128197efb676214f7fee9567ba03adf04bcc6a3735"
    end
    on_intel do
      url "https://cli.bodo-app.com/v/2026.1010.3815-rc/bodo-linux-x64"
      sha256 "2165c276b41312216f42a3b9d59452a49daf63777272e183cd7e30e1b5b2db1c"
    end
  end

  def install
    bin.install Dir["bodo-*"].first => "bodo"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/bodo version")
  end
end
