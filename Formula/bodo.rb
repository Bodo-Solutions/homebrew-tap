# Formula/bodo.rb — erzeugt aus dem Kanal-Manifest, nicht von Hand ändern.
#
# Quelle: scripts/cli-kanaele.ts (Verb `rendern`). Fassung und jede Prüfsumme stammen aus
# https://cli.bodo-app.com/stable/manifest.json — eine Wahrheitsquelle für alle Kanäle.
class Bodo < Formula
  desc "Kommandozeile der Bodo-Unternehmensplattform"
  homepage "https://cli.bodo-app.com"
  url "https://cli.bodo-app.com/v/2026.1110.4718/bodo-darwin-arm64"
  version "2026.1110.4718"
  sha256 "b3482bab29ab6a268cd40b80ad1b723c580993f46e92e2446524473252492b22"
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
      url "https://cli.bodo-app.com/v/2026.1110.4718/bodo-linux-arm64"
      sha256 "a31ed0dff4accdaca9e1d28cf93f3b902d86209b4ca2a45f920c0f9d831fa90d"
    end
    on_intel do
      url "https://cli.bodo-app.com/v/2026.1110.4718/bodo-linux-x64"
      sha256 "ebea225ff1b114387c7d5066d41f05e45b27d3bfc9c8e0dbc7ba01398dade92f"
    end
  end

  def install
    bin.install Dir["bodo-*"].first => "bodo"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/bodo version")
  end
end
