# Formula/bodo.rb — erzeugt aus dem Kanal-Manifest, nicht von Hand ändern.
#
# Quelle: scripts/cli-kanaele.ts (Verb `rendern`). Fassung und jede Prüfsumme stammen aus
# https://cli.bodo-app.com/stable/manifest.json — eine Wahrheitsquelle für alle Kanäle.
class Bodo < Formula
  desc "Kommandozeile der Bodo-Unternehmensplattform"
  homepage "https://cli.bodo-app.com"
  url "https://cli.bodo-app.com/v/2026.1109.4716/bodo-darwin-arm64"
  version "2026.1109.4716"
  sha256 "b91a0b6a6071921c8fd81bea2007a5a02712bc8af15b444cf9841ef6ae9f50cc"
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
      url "https://cli.bodo-app.com/v/2026.1109.4716/bodo-linux-arm64"
      sha256 "1e3adda45f7d51df533bf417710b05d84c37f65393dd2b3877248180454ba833"
    end
    on_intel do
      url "https://cli.bodo-app.com/v/2026.1109.4716/bodo-linux-x64"
      sha256 "021b449e9c3ed30c2e42acdeb7f1677d5a712f991b20918bfc14bcf26c26e69e"
    end
  end

  def install
    bin.install Dir["bodo-*"].first => "bodo"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/bodo version")
  end
end
