# Formula/bodo-rc.rb — erzeugt aus dem Kanal-Manifest, nicht von Hand ändern.
#
# Quelle: scripts/cli-kanaele.ts (Verb `rendern`). Fassung und jede Prüfsumme stammen aus
# https://cli.bodo-app.com/rc/manifest.json — eine Wahrheitsquelle für alle Kanäle.
class BodoRc < Formula
  desc "Kommandozeile der Bodo-Unternehmensplattform"
  homepage "https://cli.bodo-app.com"
  url "https://cli.bodo-app.com/v/2026.1026.4459-rc/bodo-darwin-arm64"
  version "2026.1026.4459-rc"
  sha256 "f07425a06a2815ffabccd1991a5515539cda6f51d0f7ca8d48259212c5916e82"
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
      url "https://cli.bodo-app.com/v/2026.1026.4459-rc/bodo-linux-arm64"
      sha256 "73952085b3f4de167587f16f267f7832a9eda7a3d4320fee00584516ddf85b8f"
    end
    on_intel do
      url "https://cli.bodo-app.com/v/2026.1026.4459-rc/bodo-linux-x64"
      sha256 "0e043ac88e5ca7870c7c17d00b93e8d09fac1f22f6067fd57e70b0ab3b24f304"
    end
  end

  def install
    bin.install Dir["bodo-*"].first => "bodo"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/bodo version")
  end
end
