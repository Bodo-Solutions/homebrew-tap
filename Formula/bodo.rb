# Formula/bodo.rb — erzeugt aus dem Kanal-Manifest, nicht von Hand ändern.
#
# Quelle: scripts/cli-kanaele.ts (Verb `rendern`). Fassung und jede Prüfsumme stammen aus
# https://cli.bodo-app.com/stable/manifest.json — eine Wahrheitsquelle für alle Kanäle.
class Bodo < Formula
  desc "Kommandozeile der Bodo-Unternehmensplattform"
  homepage "https://cli.bodo-app.com"
  url "https://cli.bodo-app.com/v/2026.1024.4348/bodo-darwin-arm64"
  version "2026.1024.4348"
  sha256 "8a281f4c5c02cd9040225d1ada2884148d1da11381659b6f90ac643cacb00e00"
  license :cannot_represent

  livecheck do
    url "https://cli.bodo-app.com/stable/manifest.json"
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
      url "https://cli.bodo-app.com/v/2026.1024.4348/bodo-linux-arm64"
      sha256 "87a200c0b1106559ef022272589a1d47afb18cbe20bcd933bca66a874599ae38"
    end
    on_intel do
      url "https://cli.bodo-app.com/v/2026.1024.4348/bodo-linux-x64"
      sha256 "40e92d997627591da1363a0f75b0af8841dba1032baf69fd5fb04a3899984a9b"
    end
  end

  def install
    bin.install Dir["bodo-*"].first => "bodo"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/bodo version")
  end
end
